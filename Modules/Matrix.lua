local Dta = select(2, ...)

--  Rift coordinate system
--	yaw     pitch   roll
--	y       x       z

-- rift rotation order:
-- roll => yaw => pitch, or
--  z   =>  y  =>  x
-- angles rotate in negative direction
-- (looks like it was supposed to be X=>Y>=>Z rotation but someone cofused row and colum indices...)

local Matrix = {}

function Matrix.dump(m)
	for i = 1, 3, 1 do
		print(string.format("| % 1.4f  % 1.4f  % 1.4f |", m[i][1], m[i][2], m[i][3]))
	end
end

function Matrix.Multiply(left, right)
	local result = { { 0, 0, 0}, { 0, 0, 0}, { 0, 0, 0} }
	for i = 1, 3, 1 do
		for j = 1, 3, 1 do
			local field = 0
			for k = 1, 3, 1 do
				field = field + left[i][k]*right[k][j]
			end
			result[i][j] = field
		end
	end
	return result
end

function Matrix.Transform(m, v)
	local res = {}
	for i=1, 3, 1 do
		res[i] = m[i][1] * v[1] + m[i][2] * v[2] + m[i][3] * v[3]
	end
	return res
end

function Matrix.createZYX(rx, ry, rz, clockwise)
	local matr = { {}, {}, {} }
	local cy, cx, cz, sy, sx, sz
	cx = math.cos(rx); cy = math.cos(ry); cz = math.cos(rz);
	if clockwise then
		sx = math.sin(-rx); sy = math.sin(-ry); sz = math.sin(-rz);
	else
		sx = math.sin(rx); sy = math.sin(ry); sz = math.sin(rz);
	end
	
	matr[1][1] =  cz*cy;
	matr[1][2] = -sz*cy;
	matr[1][3] =  sy;

	matr[2][1] =  cx*sz + sx*sy*cz;
	matr[2][2] =  cz*cx - sx*sy*sz;
	matr[2][3] = -sx*cy;

	matr[3][1] =  sx*sz - cx*sy*cz;
	matr[3][2] =  sx*cz + cx*sy*sz;
	matr[3][3] =  cx*cy;
	return matr
end

local function NEAR_ZERO(val)
	return math.abs(val) < 1e-15
end

function Matrix.ToZYX(rot, clockwise)
	local c, s
	local x, y, z

	if rot[1][3] > 1.0 then 		y =  0.5 * math.pi
	elseif rot[1][3] < -1.0 then 	y = -0.5 * math.pi
	else							y = math.asin(rot[1][3])
	end
	
	local cos_y = math.cos(y)
	
	if not NEAR_ZERO(cos_y) then
		-- Z
		s = -rot[1][2]/cos_y
		c =  rot[1][1]/cos_y
		z = math.atan2(s,c)

		-- X
		s = -rot[2][3]/cos_y
		c =  rot[3][3]/cos_y
		x = math.atan2(s,c)
			-- matr[2][2] =  cz*cx - sx*sz = cos(x+z)
	else	-- matr[2][1] =  cx*sz + sx*cz = sin(x+z); matr[3][1] =  sx*sz - cx*cz;
		-- gimbal lock, z and x rotation give identical results
		z = 0.0
		x = math.atan2(rot[2][1], rot[2][2])
		--	matr[2][1] =  cx*sz - sx*cz;
		if y < 0 then
			x = -x
--			y = -y
--			z = -z
		end
	end
	if clockwise then
		return -x, -y, -z
	end
	return x, y, z
end

Dta.Matrix = Matrix
