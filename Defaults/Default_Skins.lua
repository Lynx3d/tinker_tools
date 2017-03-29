local Dta = select(2, ...)

local skin = {}
local itemDB = Dta.Defaults.ItemDB

-----------
-- Brick --
-----------
skin["Brown Brick"] = {
	German    = "Brauner Ziegel",
	French    = "Brique brune",
	category  = "Brick",
	tile      = itemDB["I296C209A26B7D855,07F0B32DA1DB49D2,,,,,,"],
	rectangle = itemDB["I296C20993F79CDBE,D90A2BAE1B474B70,,,,,,"],
	plank     = itemDB["I296C20971A76948D,45D55944C8DB0478,,,,,,"],
	cube      = itemDB["I296C20967263B3C3,4BFE645BDD20A963,,,,,,"],
	triangle  = itemDB["I073E1B3A25ABB71D,29E3DC76D58EDB81,,,,,,"],
	pole      = itemDB["I296C209846B36DBE,D9AD8F345D5BEF37,,,,,,"],
	sphere    = itemDB["I43A6E038332DD71C,DC3C5E3A9D3B088A,,,,,,"],
	disc      = itemDB["IFA704C5663135ADF,070BA63B822BB231,,,,,,"]
}
skin["Dark Brick"] = {
	German    = "Dunkler Ziegel",
	French    = "Brique foncée",
	category  = "Brick",
	tile      = itemDB["I6D568BFE47182F04,1DFD6FE492757B86,,,,,,"],
	rectangle = itemDB["I744AC6D2299A6548,00C5DB25E2471D10,,,,,,"],
	plank     = itemDB["I35CDC7222822084E,0B56463EA48971F7,,,,,,"],
	cube      = itemDB["I7F7C60FB317D9615,89E537A4C9D4E200,,,,,,"],
	triangle  = itemDB["I7DD150DC74862B00,4B23ABF50891F95C,,,,,,"],
	pole      = itemDB["I6DB2D83700D7C59A,20E4FAC5947B5DF0,,,,,,"],
	sphere    = itemDB["I5E33C4F876B8130C,261E707F0D86DA95,,,,,,"],
	disc      = itemDB["I6E1F16D340C19D59,6853D90BFE9644C2,,,,,,"]
}
skin["Grey Brick"] = {
	German    = "Grauer Ziegel",
	French    = "Brique grise",
	category  = "Brick",
	tile      = itemDB["I4E10406235D4540A,20E4756DE87B93A8,,,,,,"],
	rectangle = itemDB["I63243ACD6B14FB2E,CCC6908778E4941C,,,,,,"],
	plank     = itemDB["I2990730D3C721518,E70235D65C25DB09,,,,,,"],
	cube      = itemDB["I48145FF6021EC006,28398A27D8ECB1C2,,,,,,"],
	triangle  = itemDB["I7190DD7778307B52,225338DB7F1C91D7,,,,,,"],
	pole      = itemDB["I4803D7391C67A8A7,1F095A77D139CAED,,,,,,"],
	sphere    = itemDB["I59C937374D2C35C3,604AE297A10E7EC3,,,,,,"],
	disc      = itemDB["I7BA38E7E1A110261,8019A72AFD7A8AAC,,,,,,"]
}
skin["Mossy Brick"] = {
	German    = "Moosiger Ziegel",
	French    = "Brique moussue",
	category  = "Brick",
	tile      = itemDB["I073E1B3F29924608,1CCC2F2CD61807A0,,,,,,"],
	rectangle = itemDB["I073E1B3E772473D9,3420563DD9F57D68,,,,,,"],
	plank     = itemDB["I073E1B3C6C1EFF1C,2CECCE90F2B24CE0,,,,,,"],
	cube      = itemDB["I073E1B3B5CE2309B,D8C9E0A8DC225694,,,,,,"],
	triangle  = itemDB["I073E1B4021744470,26C13F685E095120,,,,,,"],
	pole      = itemDB["I073E1B3D5C2DB9D2,F0BA3A29BBF27856,,,,,,"],
	sphere    = itemDB["I53795D7204ABF8FE,B82FA73A39762C6B,,,,,,"],
	disc      = itemDB["I28334F4E209BE38E,1B92DA346FB03B0E,,,,,,"]
}
skin["Red Brick"] = {
	German    = "Roter Ziegel",
	French    = "Brique rouge",
	category  = "Brick",
	tile      = itemDB["I3F97A13C3095C5DC,1D458A0CC04B0061,,,,,,"],
	rectangle = itemDB["I1BD2BE265E8D9C87,52448B947FE99E82,,,,,,"],
	plank     = itemDB["I1BA3B34224BD7009,4F5F957F993387A0,,,,,,"],
	cube      = itemDB["I17FF59E94974850B,DE2374ACC032A039,,,,,,"],
	triangle  = itemDB["I2E301FE517C6E37F,F25837DF14CE90CB,,,,,,"],
	pole      = itemDB["I3B4A6DE87539A6BC,FEDE1C131B007372,,,,,,"],
	sphere    = itemDB["I116B8078149D9AAD,25BEA3901203D2F2,,,,,,"],
	disc      = itemDB["I1B342F61466138C6,31683C8AB501F5C0,,,,,,"]
}
-------------
-- Glowing --
-------------
skin["Blue Blinking"] = {
	German    = "Blau Blinkend",
	French    = "Bleu Clignotante",
	category  = "Glowing",
	tile      = itemDB["I0D6091F5577FC9B8,8977F2BBF1622B54,,,,,,"],
	rectangle = itemDB["I7EBC874326381067,3B0EDC1C5693A3FB,,,,,,"],
	plank     = itemDB["I4FBE4CF0733E92F0,C5F0EBF4D4FCBFEC,,,,,,"],
	cube      = itemDB["I6B9DC370498E8EB2,4FDCA10043707C39,,,,,,"],
	triangle  = itemDB["I0C052D7247239F80,0336FE69220F5566,,,,,,"],
	pole      = itemDB["I6A44ED9E0555B4E2,E679382E3439EDEE,,,,,,"],
	sphere    = itemDB["I781D026B30CE59D7,19E5906064D12846,,,,,,"],
	disc      = itemDB["I7EC0A8891FB9CA89,39D2723A905B0FD4,,,,,,"]
}
skin["Blue Glowing"] = {
	German    = "Blau Leuchtend",
	French    = "Bleu Luminescent",
	category  = "Glowing",
	tile      = itemDB["I0F301FDE75740C8C,4D7CC1D2D79CF639,,,,,,"],
	rectangle = itemDB["I113820C517D3C9FE,3CF58B7266CBD298,,,,,,"],
	plank     = itemDB["I1DF6D087160B10D5,4157F7BA01FA4EC1,,,,,,"],
	cube      = itemDB["I044DC0F26C4F2294,F8839ECD7CBFA4E2,,,,,,"],
	triangle  = itemDB["I5A895ECA0E92CE54,D3BEDC46951A8F96,,,,,,"],
	pole      = itemDB["I2925B2AB735F274A,F6C679C8F808BF91,,,,,,"],
	sphere    = itemDB["I13512B0645333C92,1E0BCE6CE4BF87D9,,,,,,"],
	disc      = itemDB["I4318097900591EE2,B7D8ABB503901AC9,,,,,,"]
}
skin["Green Blinking"] = {
	German    = "Grün Blinkend",
	French    = "Vert Clignotante",
	category  = "Glowing",
	tile      = itemDB["I3D894F0A4F34D392,4CBDB65FD4BFF026,,,,,,"],
	rectangle = itemDB["I62EE36C607F9D626,279F8F713919DD5D,,,,,,"],
	plank     = itemDB["IFE425AA173F0FEC9,3AD9A40A1D03F74A,,,,,,"],
	cube      = itemDB["IFF4EEEFD05C7D7F3,4269532B8248E1BB,,,,,,"],
	triangle  = itemDB["I4464D8CA7270231A,7F2655A16FC47860,,,,,,"],
	pole      = itemDB["IFCBDC97B0A89DAB2,218B6DA4AD5CD426,,,,,,"],
	sphere    = itemDB["I4EE83B3C1B96F2E9,41020CA651D0697C,,,,,,"],
	disc      = itemDB["I3BCB898555FC3FCD,5EB855D9F49B6328,,,,,,"]
}
skin["Green Glowing"] = {
	German    = "Grün Leuchtend",
	French    = "Vert Luminescent",
	category  = "Glowing",
	tile      = itemDB["IFF3ECC126AEDC433,48BA4E866E92D54F,,,,,,"],
	rectangle = itemDB["I3BB1ECDA3E916BE0,4F120602C2840E5A,,,,,,"],
	plank     = itemDB["I4208B13D15A58794,C2B72B762661E67B,,,,,,"],
	cube      = itemDB["IFC4AC24351DBF123,0D199D173B855F2E,,,,,,"],
	triangle  = itemDB["IFF670DFC2956C5AC,060A3EC7E3ACFE7F,,,,,,"],
	pole      = itemDB["I409EB7630D748B70,187A5AC75D32A32A,,,,,,"],
	sphere    = itemDB["I46A4B9414754A0C5,E13E3D4D99C611F0,,,,,,"],
	disc      = itemDB["I6843A7E24EDB2CF8,7C0A779B593EF447,,,,,,"]
}
skin["Grey Blinking"] = {
	German    = "Grau Blinkend",
	French    = "Gris Clignotante",
	category  = "Glowing",
	tile      = itemDB["I2056207661F6B98E,EAD6A204D53698D4,,,,,,"],
	rectangle = itemDB["I216336C30E5F76DF,372CBF334B163552,,,,,,"],
	plank     = itemDB["I1E20DAAA0A8D0316,09855856C8CC454E,,,,,,"],
	cube      = itemDB["I351E7C0202FF4871,FD63CF4E23B8ABA2,,,,,,"],
	triangle  = itemDB["I324F27DE71B4886F,03F115321D49EF2B,,,,,,"],
	pole      = itemDB["I670D3C670041E799,0EC0D800F73DB740,,,,,,"],
	sphere    = itemDB["I38B6AAD129669C8A,ECE776B13B30C2C8,,,,,,"],
	disc      = itemDB["I1E797E770D36EC1A,166E1C4C5A251E96,,,,,,"]
}
skin["Grey Glowing"] = {
	German    = "Grau Leuchtend",
	French    = "Gris Luminescent",
	category  = "Glowing",
	tile      = itemDB["I1133F573658C7042,EAD57D83CDFAC855,,,,,,"],
	rectangle = itemDB["I2DD9F2C94E6979B7,383F5D46ABF1C010,,,,,,"],
	plank     = itemDB["I203DBD530460D72D,3177E474A8029E6C,,,,,,"],
	cube      = itemDB["I176C919D075316BD,BDCB646B9D5849C3,,,,,,"],
	triangle  = itemDB["I2BA2E3431CBF8446,FA8E8F2851F732EF,,,,,,"],
	pole      = itemDB["I2F33BFB877DCAA8D,168BEFA63998388C,,,,,,"],
	sphere    = itemDB["I1C4344E0223D3750,29A738CF2EC16BEB,,,,,,"],
	disc      = itemDB["I363B83DD6F7F1F98,257185F7E7598CFB,,,,,,"]
}
skin["Light Blue Blinking"] = {
	German    = "Hellblau Blinkend",
	French    = "Bleu clair Clignotante",
	category  = "Glowing",
	tile      = itemDB["IFDDA850F7EE67CDA,5BF62C5DF610315A,,,,,,"],
	rectangle = itemDB["I52F9E29F40C03D42,0164025B6FDD0989,,,,,,"],
	plank     = itemDB["I6665547154F0663E,55231A6F68926F38,,,,,,"],
	cube      = itemDB["I06C410615F1ED45D,3D906D2A4D2DE884,,,,,,"],
	triangle  = itemDB["I48C331DD6220FD55,F0FD835EF1DC9AD8,,,,,,"],
	pole      = itemDB["IFE6ABD131F3B92DE,4AC699C87CC3BB90,,,,,,"],
	sphere    = itemDB["I5886DB2F0B52972F,07C3C67BE0CE9C21,,,,,,"],
	disc      = itemDB["I3F5E551118C3663E,C8F4645610FA0287,,,,,,"]
}
skin["Light Blue Glowing"] = {
	German    = "Hellblau Leuchtend",
	French    = "Bleu clair Luminescent",
	category  = "Glowing",
	tile      = itemDB["I3DECC99E323D824B,1F8296A8E764C228,,,,,,"],
	rectangle = itemDB["I494A9A1659778A00,7DCE163D94247522,,,,,,"],
	plank     = itemDB["IFCF9FB54637B43BB,524C2695838C3057,,,,,,"],
	cube      = itemDB["I49D46B776F4D76CB,29550418D2D64ED0,,,,,,"],
	triangle  = itemDB["I6D562CCE7875D9B3,7C2073F97E5F9EEB,,,,,,"],
	pole      = itemDB["I4EE95681567E9523,53945A0C93A97CE0,,,,,,"],
	sphere    = itemDB["I5013CB0D60F06E9E,0210DC1562C03151,,,,,,"],
	disc      = itemDB["I468BA9EB46F13843,EBEBF22226578D44,,,,,,"]
}
skin["Light Green Blinking"] = {
	German    = "Hellgrün Blinkend",
	French    = "Vert clair Clignotante",
	category  = "Glowing",
	tile      = itemDB["I4183B58D5A9F406D,1B06F3F7F44B9DEA,,,,,,"],
	rectangle = itemDB["I779D1F4912AA9548,E2CD0DA699990FBE,,,,,,"],
	plank     = itemDB["I1AE9C27106FEB712,DCCE1D0125D93153,,,,,,"],
	cube      = itemDB["I7E23ADA305709BEB,09F56EA25CE57F6E,,,,,,"],
	triangle  = itemDB["I0A3BD2AA24FBB529,B389D1E59D40472D,,,,,,"],
	pole      = itemDB["I4BDABE1C54D68B5F,4D97258EFBD4D414,,,,,,"],
	sphere    = itemDB["I6B353EAF78334EB9,E930999D429F2E75,,,,,,"],
	disc      = itemDB["I02375D80238E8983,40110850134A17C7,,,,,,"]
}
skin["Light Green Glowing"] = {
	German    = "Hellgrün Leuchtend",
	French    = "Vert clair Luminescent",
	category  = "Glowing",
	tile      = itemDB["I5D90EDDD78815EBC,BB3CA2044F4E9391,,,,,,"],
	rectangle = itemDB["I6D33EE872DEEE619,33BE373165603EDA,,,,,,"],
	plank     = itemDB["I11A9E8C710A50D2A,4B0BAAD1B76B6AAB,,,,,,"],
	cube      = itemDB["I75F42BA5163FB181,F67DA899426F875D,,,,,,"],
	triangle  = itemDB["I7B82FFA365D68CFA,D8579512A532BE10,,,,,,"],
	pole      = itemDB["I56E8F74861E6AD62,F22486B041B5B794,,,,,,"],
	sphere    = itemDB["I66BE88BD3601DCC2,D72E021D1C130327,,,,,,"],
	disc      = itemDB["I755601CD669846EC,11B984DF2B0D02DC,,,,,,"]
}
skin["Orange Blinking"] = {
	German    = "Orange Blinkend",
	French    = "Orange Clignotante",
	category  = "Glowing",
	tile      = itemDB["I6673DEC7215643B2,7F73B94815406BA1,,,,,,"],
	rectangle = itemDB["I6B9BA8657F49E91F,89C3A5A621AF82FA,,,,,,"],
	plank     = itemDB["IFB43FEC519F61110,3D08CB4C98BE59BF,,,,,,"],
	cube      = itemDB["I3CF82F593244B155,A0B65A5573FF2CAA,,,,,,"],
	triangle  = itemDB["I5457081251242A63,4C283678D213BA48,,,,,,"],
	pole      = itemDB["I49C66518037D5570,49CAE3B63FC43AA6,,,,,,"],
	sphere    = itemDB["I5A7F7B4E5352C4C5,2740907B62A97B9C,,,,,,"],
	disc      = itemDB["I5C1DA0622AD03111,F6D9F19C4A4AF9B9,,,,,,"]
}
skin["Orange Glowing"] = {
	German    = "Orange Leuchtend",
	French    = "Orange Luminescent",
	category  = "Glowing",
	tile      = itemDB["IFE2A6E312F33700E,5B035A04FE131827,,,,,,"],
	rectangle = itemDB["I511070740B1F83E5,0CC1D62A92317482,,,,,,"],
	plank     = itemDB["I4557863A3987D200,D4E2B19B479EFB40,,,,,,"],
	cube      = itemDB["I44A72A35369E6F00,63BCB14B4F5707E9,,,,,,"],
	triangle  = itemDB["IFFAF08D542524202,3CDB9A5B38ADE780,,,,,,"],
	pole      = itemDB["I411FC18B368D9A10,E1E5EFD99F2DCFF9,,,,,,"],
	sphere    = itemDB["I4D61F6CF7829FC5D,E64C2E4B8C118FCD,,,,,,"],
	disc      = itemDB["I70929DB31A289BA0,1EDBEA3561D21540,,,,,,"]
}
skin["Pink Blinking"] = {
	German    = "Pink Blinkend",
	French    = "Rose Clignotante",
	category  = "Glowing",
	tile      = itemDB["I184AF45E36549923,1E562EC96CF2A820,,,,,,"],
	rectangle = itemDB["I6E9CA5A55D55EBB7,3143E0F418E04249,,,,,,"],
	plank     = itemDB["I4DCF714E7537E072,16AC96BFA378DD20,,,,,,"],
	cube      = itemDB["I4FEC176A3A9A44F5,43FDCC49256F39C4,,,,,,"],
	triangle  = itemDB["I6BE1788C6BA850D8,FFBC9DD366233130,,,,,,"],
	pole      = itemDB["I4C1B42B30E64851C,F39AB88164883124,,,,,,"],
	sphere    = itemDB["I6DCEC53B5B66F42A,53A4501105049C06,,,,,,"],
	disc      = itemDB["I65910DA26663DF8D,382CBE7C0F6FE86C,,,,,,"]
}
skin["Pink Glowing"] = {
	German    = "Pink Leuchtend",
	French    = "Rose Luminescent",
	category  = "Glowing",
	tile      = itemDB["I457B916B34A1ADBE,21E234B5FBDAB077,,,,,,"],
	rectangle = itemDB["I53DF679B1396F052,C77E96780A418398,,,,,,"],
	plank     = itemDB["I52F58DE70DD8FA2F,D4D8265918720340,,,,,,"],
	cube      = itemDB["I541F49E7179E7560,BC29281C4FF2356E,,,,,,"],
	triangle  = itemDB["I62CC51BA41AE4D0E,13D19D21F18CF3AD,,,,,,"],
	pole      = itemDB["I5019D244446BFA4C,0952EAAD6FEBBDA3,,,,,,"],
	sphere    = itemDB["I597ACF2004B15A6D,4B0C4868E2C14193,,,,,,"],
	disc      = itemDB["I0120B56228F16079,5A1674DE818F8390,,,,,,"]
}
skin["Purple Blinking"] = {
	German    = "Violett Blinkend",
	French    = "Violet Clignotante",
	category  = "Glowing",
	tile      = itemDB["I1A9341BA27CD0B6D,107CAE013B2421F1,,,,,,"],
	rectangle = itemDB["I71D3721D70012D0B,0634AF37651A268D,,,,,,"],
	plank     = itemDB["I50D2C1175408C992,2B9BA8D26D835587,,,,,,"],
	cube      = itemDB["I654C92BB6A42B46A,59EDBEC22A7A2DDF,,,,,,"],
	triangle  = itemDB["I7D10C4E4029D0CEE,29C68FCB28FE215A,,,,,,"],
	pole      = itemDB["I5B1C55EF15337E20,F70D932A4E52ADCF,,,,,,"],
	sphere    = itemDB["I0C96462806E72126,E585E07CB90132F4,,,,,,"],
	disc      = itemDB["I707EF7577021F1D1,280C4E1CFED08473,,,,,,"]
}
skin["Purple Glowing"] = {
	German    = "Violett Leuchtend",
	French    = "Violet Luminescent",
	category  = "Glowing",
	tile      = itemDB["I467AF2FB3E91183B,524C966DC4145D52,,,,,,"],
	rectangle = itemDB["I65DCBDFC1DEF6E6F,DDDA86916DE73928,,,,,,"],
	plank     = itemDB["I65BDD56B5A358404,5721D266930C848B,,,,,,"],
	cube      = itemDB["I55A9EF901FC6F190,285EB47B21CC24C9,,,,,,"],
	triangle  = itemDB["I72E5F3974CCB8A35,D5FE34E0B313EBA9,,,,,,"],
	pole      = itemDB["I66BC01E50CF6A841,3D752F626738C5D5,,,,,,"],
	sphere    = itemDB["I11C947F44F5B3EEF,84A41B7F9E583788,,,,,,"],
	disc      = itemDB["I7669FF194E55E5D2,491FE391890854AD,,,,,,"]
}
skin["Red Blinking"] = {
	German    = "Rot Blinkend",
	French    = "Rouge Clignotante",
	category  = "Glowing",
	tile      = itemDB["I1EDCD3EB034426D0,823142F3C08E10E8,,,,,,"],
	rectangle = itemDB["I2030D4AE5B379522,C5293DDCEF953FBB,,,,,,"],
	plank     = itemDB["I5D2A3BAB26070AA2,37301EEE8D4D2052,,,,,,"],
	cube      = itemDB["I1A73997539D0628D,F198964320F42578,,,,,,"],
	triangle  = itemDB["I226176EB1CC35509,15267D963B83D75E,,,,,,"],
	pole      = itemDB["I746013632BFD453C,01E015EAD95FCDBF,,,,,,"],
	sphere    = itemDB["I16D0E97F574AEE21,2CC76CF412015214,,,,,,"],
	disc      = itemDB["I0E5B3BAA43DF0579,E4117C9E11887A25,,,,,,"]
}
skin["Red Glowing"] = {
	German    = "Rot Leuchtend",
	French    = "Rouge Luminescent",
	category  = "Glowing",
	tile      = itemDB["I4E2EE8C656C56F88,349CB0F4ABC52A58,,,,,,"],
	rectangle = itemDB["I79A55C7E4D4CC7F4,01195B2832E4A0C0,,,,,,"],
	plank     = itemDB["I7894DDF476387D1D,12C4F7AD16C68BDD,,,,,,"],
	cube      = itemDB["I5832C18D58FFB7F6,E2B8B602AEFEB9DA,,,,,,"],
	triangle  = itemDB["I1429C29A5BA24624,7887B356A5C73010,,,,,,"],
	pole      = itemDB["I79ACF21101478C5A,0AF6644FF4C92C3F,,,,,,"],
	sphere    = itemDB["I1B4E52FD5C9B53F5,7D72C5B170D57B3B,,,,,,"],
	disc      = itemDB["I23FB3ADD34715732,E846058002715BFD,,,,,,"]
}
skin["White Blinking"] = {
	German    = "Weiß Blinkend",
	French    = "Blanc Clignotante",
	category  = "Glowing",
	tile      = itemDB["I309E2EED0186DE07,EFDF39AD144EB66D,,,,,,"],
	rectangle = itemDB["I233E882A73CB075D,BECD299B804D28C8,,,,,,"],
	plank     = itemDB["I68DE237765D15DE1,DD11C99FDD6F8E33,,,,,,"],
	cube      = itemDB["I2004C4BA6EAD0B98,FB69070549F5D711,,,,,,"],
	triangle  = itemDB["I2AEEBA0D525B66CD,60CAB03663593179,,,,,,"],
	pole      = itemDB["I7DCE348601CABA39,39C84F9D931650DB,,,,,,"],
	sphere    = itemDB["I00575AC6550382DD,243437D7E9F91090,,,,,,"],
	disc      = itemDB["I13206FE311C1FFD4,2F4C1F607EAB605D,,,,,,"]
}
skin["White Glowing"] = {
	German    = "Weiß Leuchtend",
	French    = "Blanc Luminescent",
	category  = "Glowing",
	tile      = itemDB["I6DB7D52C0E831124,16E67D5755EF86F1,,,,,,"],
	rectangle = itemDB["I2605A810595AD4CC,2B1F409333A23932,,,,,,"],
	plank     = itemDB["I1487FDC14B87AA54,C3886A79BDDA0890,,,,,,"],
	cube      = itemDB["I5CB8A6800EC13E44,E0D85B8E5F3110C2,,,,,,"],
	triangle  = itemDB["I1A9DBA1B11134E76,EF19D60C052BAE4A,,,,,,"],
	pole      = itemDB["I1D1AB70F2BD642DF,B37ECC9FC0D078F0,,,,,,"],
	sphere    = itemDB["I1DA6C13A701DA513,4F2CF9F211F8FC03,,,,,,"],
	disc      = itemDB["I272B3D145CAA9A90,0BD9FFFB97550D19,,,,,,"]
}
skin["Yellow Blinking"] = {
	German    = "Gelb Blinkend",
	French    = "Jaune Clignotante",
	category  = "Glowing",
	tile      = itemDB["I39967D51230A6850,BDBC8F795BB28879,,,,,,"],
	rectangle = itemDB["I2DBA5310209F1926,2708041A5064EFF6,,,,,,"],
	plank     = itemDB["I1A2D7006241007F3,53CC43307EBFD435,,,,,,"],
	cube      = itemDB["I042593D34A3D2217,6282EB972A4CF826,,,,,,"],
	triangle  = itemDB["I05C92C7C1BFC0E3A,1061B0D6BF76EC84,,,,,,"],
	pole      = itemDB["I262C6A7F40940A95,5808FACCE2EE6885,,,,,,"],
	sphere    = itemDB["I2AD4F6B17513D658,23560B31D5BFDC3E,,,,,,"],
	disc      = itemDB["I1697133059D3D138,F46A01FF0B282EDD,,,,,,"]
}
skin["Yellow Glowing"] = {
	German    = "Gelb Leuchtend",
	French    = "Jaune Luminescent",
	category  = "Glowing",
	tile      = itemDB["I327DC08A10394595,D5E0C35880ACF462,,,,,,"],
	rectangle = itemDB["I05E680E05B706411,D02A1A3DF361F41F,,,,,,"],
	plank     = itemDB["I22F92DE974A7031A,0BAA06AFB4B2DA66,,,,,,"],
	cube      = itemDB["I6B0E9E2713975781,28B47AF89BE0B704,,,,,,"],
	triangle  = itemDB["I1CACF4DE266F0A1C,592C560510CDEC04,,,,,,"],
	pole      = itemDB["I032659B732D44B5A,2070ACA5D19C4EC5,,,,,,"],
	sphere    = itemDB["I3B8D641C6FFA5D04,775D9699650976B1,,,,,,"],
	disc      = itemDB["I2B2B50943821BABB,1150AD0529D15040,,,,,,"]
}
---------------
-- Limestone --
---------------
skin["Limestone"] = {
	German    = "Kalkstein",
	French    = "Calcaire",
	category  = "Limestone",
	tile      = itemDB["I3818BAD162A76C77,DC1C64A4763AFE8C,,,,,,"],
	rectangle = itemDB["I3818BAD207A81EB9,EE1EBBB901974266,,,,,,"],
	plank     = itemDB["I3818BAD530B1947F,E65961B97AA1A075,,,,,,"],
	cube      = itemDB["I3818BAD6412DB4F4,F85BB8CE85FE679E,,,,,,"],
	triangle  = itemDB["I3818BAD05D2F4C6F,DAE9E950AF2B7EBE,,,,,,"],
	pole      = itemDB["I3818BAD4523D3998,060F153AE1676428,,,,,,"],
	sphere    = itemDB["I3818BAD371E4257E,F7513C38B300DBFF,,,,,,"],
	disc      = itemDB["I7A2176B11E144AFB,10873940C25619F2,,,,,,"]
}
skin["Baby Blue Limestone"] = {
	German    = "Babyblauer Kalkstein",
	French    = "Calcaire bleu ciel",
	category  = "Limestone",
	tile      = itemDB["I1CBA02CA1094C662,0EF972EAA2531CFF,,,,,,"],
	rectangle = itemDB["I3ECA7BD7754F9216,027A800E2D71B53B,,,,,,"],
	plank     = itemDB["I64957C922A2CE5C2,11D628E468F6A2D3,,,,,,"],
	cube      = itemDB["I5C3F6A37788F5729,199667A004F02E5D,,,,,,"],
	triangle  = itemDB["I546E5F663956487B,08684109C7FE6255,,,,,,"],
	pole      = itemDB["I5041D5F94D1B260C,EA3BC84509BEC2C7,,,,,,"],
	sphere    = itemDB["I16B87D4950DD6F11,3990C2DCDC8FD86E,,,,,,"],
	disc      = itemDB["I7E83975B3167C57B,0B565A1D39E55570,,,,,,"]
}
skin["Lavender Limestone"] = {
	German    = "Lavendel-Kalkstein",
	French    = "Calcaire améthyste",
	category  = "Limestone",
	tile      = itemDB["IFAADE2B9615824FD,2AE3B547205D4F21,,,,,,"],
	rectangle = itemDB["IFB8C87E964E763EB,0EDBFD54E7492DDF,,,,,,"],
	plank     = itemDB["I183F23F37125DFE6,DDCB2B6379E95D21,,,,,,"],
	cube      = itemDB["I35AF4075637378C5,F4A1125AEC3F5916,,,,,,"],
	triangle  = itemDB["I4141F89070E577C9,0B42D92CE3498A58,,,,,,"],
	pole      = itemDB["I256F5322545184EE,3EE070C67B2B7C0A,,,,,,"],
	sphere    = itemDB["I21D1F8154E99388E,2190E9F4B33CE27C,,,,,,"],
	disc      = itemDB["I08A68FED6C110E03,D497E81BCB494E4C,,,,,,"]
}
skin["Mint Green Limestone"] = {
	German    = "Mintgrüner Kalkstein",
	French    = "Calcaire vert menthe",
	category  = "Limestone",
	tile      = itemDB["I0F145A0E3632FC97,1562ADD196E599B2,,,,,,"],
	rectangle = itemDB["I538792E549DA1924,1334E735141425B1,,,,,,"],
	plank     = itemDB["I0A192959721B77F3,224CE60DFB031C92,,,,,,"],
	cube      = itemDB["I686B2FBB7DCDA85A,BD3C7FBFE2B3BA87,,,,,,"],
	triangle  = itemDB["I604E90BA3152F3C0,FEE39772CC7BF154,,,,,,"],
	pole      = itemDB["I2D2FFBE152E21887,0F8818CC1F9DBC1B,,,,,,"],
	sphere    = itemDB["I7AFF4E9F6ADCEBCE,6247AFBEE8061B11,,,,,,"],
	disc      = itemDB["I40416A412B4FE852,33F4DA4989D1D8D3,,,,,,"]
}
skin["Pale Yellow Limestone"] = {
	German    = "Blassgelber Kalkstein",
	French    = "Calcaire jaune pâle",
	category  = "Limestone",
	tile      = itemDB["I417A0D9B4E287F23,30CD26A3AF4669C1,,,,,,"],
	rectangle = itemDB["I2333D52544517C25,6C2FB0DAE56B005E,,,,,,"],
	plank     = itemDB["IFEAB6C7D740E1F06,73C9FFF4048D2273,,,,,,"],
	cube      = itemDB["I7DA36B0710713B3A,2AC79A146AF28630,,,,,,"],
	triangle  = itemDB["I70F84A6A5AD0F270,190008691732F396,,,,,,"],
	pole      = itemDB["I7098CB9126C1FF00,4E48B6BF0F0CEB77,,,,,,"],
	sphere    = itemDB["I68AD214817038F85,91BB9E79D57327FC,,,,,,"],
	disc      = itemDB["I18A8244D3D5817CF,FA67AA1044981ECB,,,,,,"]
}
skin["Rose Limestone"] = {
	German    = "Rosa Kalkstein",
	French    = "Calcaire rose",
	category  = "Limestone",
	tile      = itemDB["I3874323D2E537BA8,EF3AA588502E7F91,,,,,,"],
	rectangle = itemDB["I16F0248C6AFD8689,CD824DA81F2DC4D2,,,,,,"],
	plank     = itemDB["I6439F5A36F3F9DA7,2EA84E9B6D99B686,,,,,,"],
	cube      = itemDB["I6FA075CA1D4F4F92,0A8BF790C6B96975,,,,,,"],
	triangle  = itemDB["I35D2A968332F00C4,652F4FE4C45E882B,,,,,,"],
	pole      = itemDB["I488F12FF6F434FCF,56954C12463DF2D4,,,,,,"],
	sphere    = itemDB["I2A1ACD974099E1F0,FA3DC5571511F398,,,,,,"],
	disc      = itemDB["I32C7AE1A1EDB5879,EBE598C108998C25,,,,,,"]
}
skin["Tangerine Limestone"] = {
	German    = "Orangeroter Kalkstein",
	French    = "Calcaire mandarine",
	category  = "Limestone",
	tile      = itemDB["I49BE60B612275BD3,02597159049416B0,,,,,,"],
	rectangle = itemDB["IFE07E0122221B81D,35A90A3D952B2088,,,,,,"],
	plank     = itemDB["I1DA6714059F3E8A0,13D0756B91C12B3D,,,,,,"],
	cube      = itemDB["I63C10F0040A96E6D,32D9996B5BB2E9E3,,,,,,"],
	triangle  = itemDB["I04726E6733582FF8,1548B26BCA593EF2,,,,,,"],
	pole      = itemDB["I61A62BF447C2B291,0EA73AD3B4AE063B,,,,,,"],
	sphere    = itemDB["I224D2ED74E1BB0EE,D75995016650FC09,,,,,,"],
	disc      = itemDB["I74DE447D7222FBDE,58C424E986231736,,,,,,"]
}
-----------
-- Metal --
-----------
skin["Ahnkite"] = {
	German    = "Ahnkite",
	category  = "Metal",
	tile      = itemDB["I539425A144DED843,0AF5A2257EAFFA09,,,,,,"],
	rectangle = itemDB["I755733C038C2BB04,077E6A15B73EE19B,,,,,,"],
	plank     = itemDB["I0DA2D2A61680D5B9,346E017C8C99FF2A,,,,,,"],
	cube      = itemDB["I6F3859DB36BB2709,DCC9EB93D05BEB46,,,,,,"],
	triangle  = itemDB["I2188DCEE03B23356,05D897A27E577FD7,,,,,,"],
	pole      = itemDB["I268EB710194B8C15,0A36BD61D9F7C405,,,,,,"],
	sphere    = itemDB["I1956045928BEF4F7,0DEC38CA57054E7F,,,,,,"],
	disc      = itemDB["I763DA1413EC98992,AC41D8816514F954,,,,,,"],
}
skin["Atramentium"] = {
	German    = "Atramentium",
	category  = "Metal",
	tile      = itemDB["I4EFA084E0F8304AF,56A5FC7032C68D88,,,,,,"],
	rectangle = itemDB["I505A72820F11C784,07A4F7DC5865CF18,,,,,,"],
	plank     = itemDB["I77E1A3AE09E25662,3290E79D3121E2C4,,,,,,"],
	cube      = itemDB["I5E0D72991E46E7AC,B95B674BB0D4B7AD,,,,,,"],
	triangle  = itemDB["I125A25A30B02815E,B3A2AFCC6022A46B,,,,,,"],
	pole      = itemDB["I576B7FBE7265F50D,D4F63A563059327C,,,,,,"],
	sphere    = itemDB["I08D1F68773CBDDA3,2B5E53B22485AF68,,,,,,"],
	disc      = itemDB["I6ACAD3F6581320B6,6F7F58EEEF661CE0,,,,,,"],
}
skin["Bolidium"] = {
	German    = "Bolidium",
	category  = "Metal",
	tile      = itemDB["I46C77D9476FC6915,EAEB857B5EE75F83,,,,,,"],
	rectangle = itemDB["I07091771366C0825,058832207FB3EA62,,,,,,"],
	plank     = itemDB["I57EBB1970270779A,25325CF23C0AD7D7,,,,,,"],
	cube      = itemDB["I52C2009C35093DC6,84F1964D1C210F6F,,,,,,"],
	triangle  = itemDB["I65B066F74E00D904,4093EFCDF25876BC,,,,,,"],
	pole      = itemDB["I510561264F1AC8E1,3B1CD9125467538E,,,,,,"],
	sphere    = itemDB["IFE05A0D245C05443,015BB603C278AA0B,,,,,,"],
	disc      = itemDB["I4D02DC18267AEF9C,FAC549A32169368B,,,,,,"],
}
skin["Bronze"] = {
	German    = "Bronze",
	French    = "Bronze",
	category  = "Metal",
	tile      = itemDB["I5302F994283375AC,FCD4610995B98CBD,,,,,,"],
	rectangle = itemDB["I3D535EBA5E2A951A,51513FD7EFDC8066,,,,,,"],
	plank     = itemDB["I6603EC66015333C4,02B0DE81A55D8885,,,,,,"],
	cube      = itemDB["IFDAF85847069ECC2,F38BFD7257173922,,,,,,"],
	triangle  = itemDB["I435751FE261A75EB,047248A2AA276B26,,,,,,"],
	pole      = itemDB["I5C6C2AE136326474,7979892CF3A0E331,,,,,,"],
	sphere    = itemDB["I599DF6F5730EC5F4,F949C4B1D688A2C1,,,,,,"],
	disc      = itemDB["I43064738336125F9,F6547E2BE313DB0B,,,,,,"],
}
skin["Copper"] = {
	German    = "Kupfer",
	French    = "Cuivre",
	category  = "Metal",
	tile      = itemDB["I6AB0C4036E7F55BB,ECE46B0559DD0B8A,,,,,,"],
	rectangle = itemDB["I3DD92F79356E473F,341511B9D21BB771,,,,,,"],
	plank     = itemDB["I789E8BF2611BB593,15AEEC288FDC3434,,,,,,"],
	cube      = itemDB["I3F37BC9C16614A67,FE8C91EAE8155D6E,,,,,,"],
	triangle  = itemDB["I13CC6DDE5EB4CBF3,BEB21B003AA4E8B3,,,,,,"],
	pole      = itemDB["I617E64B626BC5302,84005283DE7FF744,,,,,,"],
	sphere    = itemDB["I599DF6F63C7EB5ED,FB2E0073C5AEFECE,,,,,,"],
	disc      = itemDB["I45BD9AB03F2D8F7A,349417B8B0F64332,,,,,,"],
}
skin["Gold"] = {
	German    = "Gold",
	French    = "Or",
	category  = "Metal",
	tile      = itemDB["I79BAED7B03B964C6,C03254E697824186,,,,,,"],
	rectangle = itemDB["I4DBA84834765AD7A,58E33B690A17481A,,,,,,"],
	plank     = itemDB["I15FF4B330B031214,03EC79FD984F30F1,,,,,,"],
	cube      = itemDB["I59FCF6C30F39E7EA,DFA261EBA56735FB,,,,,,"],
	triangle  = itemDB["I2049ED9E6D1B4E0C,E3D9DF961934C432,,,,,,"],
	pole      = itemDB["I184E28255EAD7124,37A42F8F8E70A0B0,,,,,,"],
	sphere    = itemDB["I599DF6F71D66415B,328AE63BB06B7052,,,,,,"],
	disc      = itemDB["I7D978086383E695C,E7CFE3E44685AFE8,,,,,,"],
}
skin["Iron"] = {
	German    = "Eisen",
	French    = "Fer",
	category  = "Metal",
	tile      = itemDB["I7CBC98471899CF5C,8098132ADB130804,,,,,,"],
	rectangle = itemDB["I11B9C2F02179AF9C,53B1A71B1E1D404E,,,,,,"],
	plank     = itemDB["I22EC967F280DD5D2,1D67E0AB94686625,,,,,,"],
	cube      = itemDB["I7DFB344B282452DF,22B0E09CFC731091,,,,,,"],
	triangle  = itemDB["I23C4D1014BDE5382,CF257D294935B5D5,,,,,,"],
	pole      = itemDB["I1F2A51075E54BF25,36B43EEB150DC716,,,,,,"],
	sphere    = itemDB["I599DF6F81BB32E78,F8DFF11CAAE71EEC,,,,,,"],
	disc      = itemDB["I0192B2FE60774270,EC1221D7817CDBBF,,,,,,"],
}
skin["Silver"] = {
	German    = "Silber",
	French    = "Argent",
	category  = "Metal",
	tile      = itemDB["I7F3829BB2914E927,16963BEEB07956DA,,,,,,"],
	rectangle = itemDB["I1A8E12EF786B7B7D,F7C811C6EB17FC5B,,,,,,"],
	plank     = itemDB["I265CB62B1B03B6EA,4D3FC42904BEDC5B,,,,,,"],
	cube      = itemDB["I1CDAD8FB19FA8980,D597CC95E5BEB05B,,,,,,"],
	triangle  = itemDB["I2C39B78D113CDCE6,0AB510CBF16ED993,,,,,,"],
	pole      = itemDB["I2AA680953BF81E12,55AB446CA22CFD44,,,,,,"],
	sphere    = itemDB["I599DF6F91AA8B52A,4153210583FBBF66,,,,,,"],
	disc      = itemDB["I15288651608C4C0E,30D948AE9ACC207D,,,,,,"],
}
-----------
-- Stone --
-----------
skin["Black Marble"] = {
	German    = "Schwarzer Marmor",
	French    = "Marbre noir",
	category  = "Stone",
	tile      = itemDB["I073E1B4612DE4C8A,F92F979003F4808F,,,,,,"],
	rectangle = itemDB["I073E1B4526891DBC,32303483297E6C39,,,,,,"],
	plank     = itemDB["I073E1B4205A5AD2C,DBA30B02D2220DFA,,,,,,"],
	cube      = itemDB["I073E1B415FB61FE2,35D4A7B10CECEB74,,,,,,"],
	triangle  = itemDB["I073E1B47696AE692,1B5009F82B87B2D4,,,,,,"],
	pole      = itemDB["I073E1B4373754E81,4EE757B2984B08C7,,,,,,"],
	sphere    = itemDB["I073E1B4404FD78A3,EECA186F0B7BEA75,,,,,,"],
	disc      = itemDB["I471E8BFC0EA98298,334F6B4E0F979E19,,,,,,"]
}
skin["Brimstone"] = {
	German    = "Schwefel",
	category  = "Stone",
	tile      = itemDB["I7C7CB5B52D30D014,F12AEE2144535EB9,,,,,,"],
	rectangle = itemDB["I1A295402638F4681,567983771AF82DF8,,,,,,"],
	plank     = itemDB["I138D39CE296827F1,110784229FDD7732,,,,,,"],
	cube      = itemDB["I431E018E3C63C152,DECC88168602FDF7,,,,,,"],
	triangle  = itemDB["I1D145A951FB687F2,3C96582F541042D6,,,,,,"],
	pole      = itemDB["I767ED0A52510D841,3F86E38F6F5298F8,,,,,,"],
	sphere    = itemDB["I6A3D08EF22F07D38,1FBCE085DC4D9188,,,,,,"],
	disc      = itemDB["I7A05F8E16906F813,34D59A9C571DDD4A,,,,,,"],
}
skin["Granite"] = {
	German    = "Granit",
	French    = "Granite",
	category  = "Stone",
	tile      = itemDB["I391DEDBA3602AEE7,0BAE6DA5E14A8F15,,,,,,"],
	rectangle = itemDB["I391DEDBB37D6C62E,209FB386C9208314,,,,,,"],
	plank     = itemDB["I391DEDBE1401B33C,BD07066F4CF5E056,,,,,,"],
	cube      = itemDB["I391DEDBF5153A1DF,E8A90FDBF6939FB8,,,,,,"],
	triangle  = itemDB["I391DEDB9407C540E,E2FB53059425FC88,,,,,,"],
	pole      = itemDB["I391DEDBD6EDB9940,B6C374BCF8057392,,,,,,"],
	sphere    = itemDB["I391DEDBC5376E825,07DD708AF171F87F,,,,,,"],
	disc      = itemDB["I471590822DD4BB08,BBD409F6967FAEA1,,,,,,"]
}
skin["Green Marble"] = {
	German    = "Grüner Marmor",
	French    = "Marbre vert",
	category  = "Stone",
	tile      = itemDB["I391DEDB7666F40AB,BBB226C82076B285,,,,,,"],
	rectangle = itemDB["I391DEDB60587B53E,C694001D10509F46,,,,,,"],
	plank     = itemDB["I391DEDB3402D4989,F3A8CA73730395E0,,,,,,"],
	cube      = itemDB["I073E1B4815A7BFC4,3EE0BB9C3C5B0811,,,,,,"],
	triangle  = itemDB["I391DEDB80182998A,BFD390E843FEDBDA,,,,,,"],
	pole      = itemDB["I391DEDB47498E0D1,D3F316F28C3CCB90,,,,,,"],
	sphere    = itemDB["I391DEDB559E08ED3,1AF279FEE6B2DFE5,,,,,,"],
	disc      = itemDB["I4F3DEDB24D02A2C2,32478B55CFF44C0F,,,,,,"]
}
skin["Greenstone"] = {
	German    = "Grünstein",
	French    = "Pierre verte",
	category  = "Brick",
	tile      = itemDB["IFF1D8E4A6A25E35C,1F129CFC26DC5AA7,,,,,,"],
	rectangle = itemDB["IFF1BEE2F77076368,408BF5DACD6542A7,,,,,,"],
	plank     = itemDB["I595317063D221222,BCB1CB6689D600F4,,,,,,"],
	cube      = itemDB["IFB192CB30B4FFEC2,6BCD9A120AAD91FF,,,,,,"],
	triangle  = itemDB["I0E057DA0036E7490,EF5E2DE384B620FB,,,,,,"],
	pole      = itemDB["I50DE65BA6500E5CB,81098C8575CBD24E,,,,,,"],
	sphere    = itemDB["I6FDA125C5A06218C,AE87F2440AFAB5E1,,,,,,"],
	disc      = itemDB["I671DEC4B6676EC51,09BB5C6E55D78F97,,,,,,"]
}
skin["Greystone"] = {
	German    = "Graustein",
	French    = "Pierre grise",
	category  = "Brick",
	tile      = itemDB["IFF1BEE2E068D20E3,DE1784EBCB8A1282,,,,,,"],
	rectangle = itemDB["IFF1BEE2D5B75764D,2D5723717AF97EFD,,,,,,"],
	plank     = itemDB["I42857375124AE699,A775AFA6E9819C92,,,,,,"],
	cube      = itemDB["I6E4C20977E99CCB8,DF7542CCA9205752,,,,,,"],
	triangle  = itemDB["I0E057DA1730AA5E3,1EF83DBC68DFC413,,,,,,"],
	pole      = itemDB["I52C62DA11FFFAF5B,A96959E6E70D4918,,,,,,"],
	sphere    = itemDB["I1B1C042B557AED8C,09CFDAA07F60975A,,,,,,"],
	disc      = itemDB["I4E582BF15BEDE239,3E82E339D762FEA6,,,,,,"]
}
skin["Plain Stone"] = {
	German    = "Einfacher Stein",
	French    = "Pierre ordinaire",
	category  = "Stone",
	tile      = itemDB["IFC27A53A7D93B3C5,28927815564C4D18,,,,,,"],
	rectangle = itemDB["IFC27A5392C8F2D7D,2011B804CCFA965A,,,,,,"],
	plank     = itemDB["IFC27A5376CAD89FE,0C2B252DD2777324,,,,,,"],
	cube      = itemDB["IFC27A53820DB3178,41B0544C88A55715,,,,,,"],
	triangle  = itemDB["I0E057DA33EC7161D,FCD4C3F5C0E8B7AB,,,,,,"],
	pole      = itemDB["IFC27A5362A2868B0,FA284ACA471A28AC,,,,,,"],
	sphere    = itemDB["I40AC238718345605,D83A9430A4B46758,,,,,,"],
	disc      = itemDB["I28CB06FA7E88F136,3B9939D780AA925B,,,,,,"]
}
skin["Tenebrean Sandstone"] = {
	German    = "Tenebrischer  Sandstein",
	category  = "Stone",
	tile      = itemDB["I2323CE7A628C486E,FEE278F0CD768E03,,,,,,"],
	rectangle = itemDB["I12E712C272394A17,3657F6113CFE0632,,,,,,"],
	plank     = itemDB["I3134244129A76F5E,CECA1285064F29C4,,,,,,"],
	cube      = itemDB["I29B854A41A0B551F,F31AE64B10EAF1E8,,,,,,"],
	triangle  = itemDB["I35F62B284902A864,6ED54694DD1918FA,,,,,,"],
	pole      = itemDB["I279635117C093ADD,0F50AD392EF072EF,,,,,,"],
	sphere    = itemDB["I29D0A9A075AC2DD5,46BC0CBB407E7042,,,,,,"],
	disc      = itemDB["I2AC3ED744F9F36AA,59A3B2B1823C7A23,,,,,,"],
}
skin["Tenebrean Slate"] = {
	German    = "Tenebrischer  Schiefer",
	category  = "Stone",
	tile      = itemDB["I10B1E45F18AFEA75,053DCDADA36D4077,,,,,,"],
	rectangle = itemDB["IFDBE806422C1AA66,CFABBA55AED77940,,,,,,"],
	plank     = itemDB["I738752287EEC5560,7C3E3D5EE8401D86,,,,,,"],
	cube      = itemDB["IFD5F53F97C1FC7A2,10E154919495BC50,,,,,,"],
	triangle  = itemDB["I441BA26A64E7FF3D,F8C05C6D38144115,,,,,,"],
	pole      = itemDB["I0FC5973452A1EF23,15D057950680E89D,,,,,,"],
	sphere    = itemDB["I06F20AC82FEB5DE6,35F069DB9DE6220D,,,,,,"],
	disc      = itemDB["I47B27F9416A476D2,3530A347FE1A3A50,,,,,,"],
}
skin["Tenebrean Stone"] = {
	German    = "Tenebrischer  Stein",
	category  = "Stone",
	tile      = itemDB["I2A38D13C3B04261E,00CC3D795E860D1A,,,,,,"],
	rectangle = itemDB["I0E65F685676C8DEA,BD32BE4948157793,,,,,,"],
	plank     = itemDB["I031A19E3131D6CD0,1FFC2285D9293CE0,,,,,,"],
	cube      = itemDB["IFC3AE4BF06AAD56B,247A59D29C57E080,,,,,,"],
	triangle  = itemDB["I70B62B3F510C7059,C795D40445AB988A,,,,,,"],
	pole      = itemDB["I340B2C6D7D6FE929,C930AE3EAA8C03C6,,,,,,"],
	sphere    = itemDB["I265819494FD57C7D,2BAA5E6FBEAA432A,,,,,,"],
	disc      = itemDB["I4FFFE9DE259B3B55,4B6BCE9C74D70B41,,,,,,"],
}
------------------
-- Painted Wood --
------------------
skin["Black Wood"] = {
	German    = "Schwarzes Holz",
	French    = "Bois noir",
	category  = "Painted Wood",
	tile      = itemDB["I225B19741ECF919B,5FCF6985FBE76B7E,,,,,,"],
	rectangle = itemDB["I1F41D458736422A4,227CCE6B4903624F,,,,,,"],
	plank     = itemDB["I49ED20CF0347AB5E,EDE3E705D657F55B,,,,,,"],
	cube      = itemDB["I2A71EFE22B8835BC,397C2A0DAEF7C210,,,,,,"],
	triangle  = itemDB["I722CC1EF160F0746,069ECB4F142A3B56,,,,,,"],
	pole      = itemDB["I1277C40C1E1D4109,0768FE1CFD703C82,,,,,,"],
	sphere    = itemDB["I4093793522C0159B,63B88BE7BC4D32AA,,,,,,"],
	disc      = itemDB["I61115417724B0103,3346799ED6917266,,,,,,"]
}
skin["Blue Wood"] = {
	German    = "Blaues Holz",
	French    = "Bois bleu",
	category  = "Painted Wood",
	tile      = itemDB["I296C2090527FF26A,36F51BEF35044AFE,,,,,,"],
	rectangle = itemDB["I296C208D1D704C59,11BDF271D73B3CDD,,,,,,"],
	plank     = itemDB["I40AC238F489B44D9,F461A18236849080,,,,,,"],
	cube      = itemDB["I40AC238C51DB6536,E3AA0C99702A890F,,,,,,"],
	triangle  = itemDB["I296C209352FAB5BB,17C13E8EBA267586,,,,,,"],
	pole      = itemDB["I40AC239212A0FB19,1E545218A1B0F61C,,,,,,"],
	sphere    = itemDB["I4690F20563706C61,F3186EBB977423AB,,,,,,"],
	disc      = itemDB["I316E0F501572B1C9,65E15CBC8BA0C01B,,,,,,"]
}
skin["Green Wood"] = {
	German    = "Grünes Holz",
	French    = "Bois vert",
	category  = "Painted Wood",
	tile      = itemDB["I296C20913F3B871C,E1D4959F081A5A79,,,,,,"],
	rectangle = itemDB["I296C208E796419FE,0A211A7DC4570BCE,,,,,,"],
	plank     = itemDB["I40AC23904F4F7F9C,E97FC82D46AA206F,,,,,,"],
	cube      = itemDB["I40AC238D623F33E2,E7CB76B993B22F16,,,,,,"],
	triangle  = itemDB["I296C20946482DFDC,41321904B96A6998,,,,,,"],
	pole      = itemDB["I40AC239314B5AEBA,3056A92D2D0E4094,,,,,,"],
	sphere    = itemDB["I30A3F79C2A4643E7,CFBACFF2921417C2,,,,,,"],
	disc      = itemDB["I3B7236883A273B68,EF464DAFC99F4889,,,,,,"]
}
skin["Grey Wood"] = {
	German    = "Graues Holz",
	French    = "Bois gris (peint)",
	category  = "Painted Wood",
	tile      = itemDB["IFE55763728218075,6E424275E575ED1E,,,,,,"],
	rectangle = itemDB["IFD4FB6B32537401B,2E647DA7A1831AA3,,,,,,"],
	plank     = itemDB["IFBC6132B6514F5F5,4E92801DA5A94749,,,,,,"],
	cube      = itemDB["I04CBFEFD21EFBA65,2007E1134147E9EB,,,,,,"],
	triangle  = itemDB["I1E48A52B523F3CAF,3C9153EBEB6EB00B,,,,,,"],
	pole      = itemDB["I2A36B24469E9891C,F87CA8DA4D4F25FF,,,,,,"],
	sphere    = itemDB["I35863C70209BC5BA,2AEA9A4911A81D16,,,,,,"],
	disc      = itemDB["I08B697CD73E5D284,3EC93269BFC4E3C5,,,,,,"]
}
skin["Orange Wood"] = {
	German    = "Oranges Holz",
	French    = "Bois orange",
	category  = "Painted Wood",
	tile      = itemDB["I382046281AC59678,21C4738225059BED,,,,,,"],
	rectangle = itemDB["I38B1938F069E41A5,2A135CF2C479FA5A,,,,,,"],
	plank     = itemDB["I2F3B97244D64F18C,FF6F935C882B2ADD,,,,,,"],
	cube      = itemDB["I478BFAAF0FAD4C3A,692D9124057CE578,,,,,,"],
	triangle  = itemDB["I4DC91D0C2351ECB9,E8847230C538EA43,,,,,,"],
	pole      = itemDB["I3D89997A414C158D,4A201047DA9BAB58,,,,,,"],
	sphere    = itemDB["I3B1B44CC17FD37AF,35875B84A6D6C7F2,,,,,,"],
	disc      = itemDB["I4F03BB16771A571E,18C4FC2A162E83F5,,,,,,"],
}
skin["Pink Wood"] = {
	German    = "Pinkes Holz",
	French    = "Bois rose",
	category  = "Painted Wood",
	tile      = itemDB["I6671FD092BBD97AF,0C8AFC14CAAE4D1C,,,,,,"],
	rectangle = itemDB["I4AB2792310D7E971,E5A8D53060EAE97B,,,,,,"],
	plank     = itemDB["I43C6B15B2B94A8EA,348FA72DBA0B243D,,,,,,"],
	cube      = itemDB["I4EB5154F67FD7999,0F8802B732943B41,,,,,,"],
	triangle  = itemDB["I2AE82CE0756220D4,E1EBE48D9F618214,,,,,,"],
	pole      = itemDB["I4BEF28FA0BA08B69,202ED0238B2BFA19,,,,,,"],
	sphere    = itemDB["I430ADCEE654B2502,DE443AD8CE6467B7,,,,,,"],
	disc      = itemDB["I6595EABA50F5F3ED,F8C2DE5A36202291,,,,,,"],
}
skin["Purple Wood"] = {
	German    = "Violettes Holz",
	French    = "Bois violet",
	category  = "Painted Wood",
	tile      = itemDB["I508B34B957B008DC,317E3892829BB98A,,,,,,"],
	rectangle = itemDB["I724FBE48147B0EB7,CFCCD850D57F148B,,,,,,"],
	plank     = itemDB["I747D2CB03E1D6BAA,CF7D605B9448FE2C,,,,,,"],
	cube      = itemDB["I549EF4A046F0819B,F34A11AB87CD1372,,,,,,"],
	triangle  = itemDB["I4934EEA76311FF33,520D955C50F0A601,,,,,,"],
	pole      = itemDB["I667069E87DB50E0C,09519BCDBD0F51C3,,,,,,"],
	sphere    = itemDB["I5B60C49967DBDD46,72BFDD81233568EC,,,,,,"],
	disc      = itemDB["I7AF14E60724FB700,F2BEE36E0EE4DBC3,,,,,,"],
}
skin["Red Wood"] = {
	German    = "Rotes Holz",
	French    = "Bois rouge",
	category  = "Painted Wood",
	tile      = itemDB["I296C209213A44A57,D229F38471CA2871,,,,,,"],
	rectangle = itemDB["I296C208F33BDC5E1,CFB7E23A8CB358E2,,,,,,"],
	plank     = itemDB["I40AC23917D1C7144,FB821F425206644A,,,,,,"],
	cube      = itemDB["I40AC238E2007C28D,E60244E1E5369AE2,,,,,,"],
	triangle  = itemDB["I296C2095060E84F6,F70B8DBB4F162467,,,,,,"],
	pole      = itemDB["I296C208C3E68A987,E2D76AF250A7C1C9,,,,,,"],
	sphere    = itemDB["I775F866D5B818D20,450C14FACAD318B9,,,,,,"],
	disc      = itemDB["I0C5CAF1B26772D55,0CFE78F9847293D1,,,,,,"]
}
skin["White Wood"] = {
	German    = "Weißes Holz",
	French    = "Bois blanc",
	category  = "Painted Wood",
	tile      = itemDB["IFC8ABCEB0BDE99BD,08005855E62E2C2D,,,,,,"],
	rectangle = itemDB["IFA1EC9315434666B,18A8CD0825FFD33E,,,,,,"],
	plank     = itemDB["IFA1AE7594ADD5456,E4753059B4A878D0,,,,,,"],
	cube      = itemDB["I00343AC1138B4469,CF4DEE0D0937E53F,,,,,,"],
	triangle  = itemDB["I06F55391345A6B57,EA9FF73A7C069FF5,,,,,,"],
	pole      = itemDB["I2443AC703580D8DF,D9631641F95BE9EB,,,,,,"],
	sphere    = itemDB["IFD13525F5A44D6AF,53E92D28B670111F,,,,,,"],
	disc      = itemDB["I07137EA27112A05D,3927034D866A25F1,,,,,,"]
}
skin["Yellow Wood"] = {
	German    = "Gelbes Holz",
	French    = "Bois jaune",
	category  = "Painted Wood",
	tile      = itemDB["I79EED1FE12E22261,830E1623B1C381FB,,,,,,"],
	rectangle = itemDB["I74EEA42D1CFF735F,D66EAB74F966ABE0,,,,,,"],
	plank     = itemDB["I7FA1E26671F74743,B7EC4F8117B16987,,,,,,"],
	cube      = itemDB["I6C0C73C81B0714D6,4A33BB10576BB5B5,,,,,,"],
	triangle  = itemDB["I5369D5E9526A025E,D6344E060047C47A,,,,,,"],
	pole      = itemDB["I7BA99FD93FC632EA,254AB326928F05B4,,,,,,"],
	sphere    = itemDB["I709DA24B41BCF9F2,D6C9317B1D434C67,,,,,,"],
	disc      = itemDB["I7DABF6E013163282,3E95BEC770535E3E,,,,,,"]
}
----------
-- Wood --
----------
skin["Carved Wood"] = {
	German    = "Geschnitztes Holz",
	French    = "Bois sculpté",
	category  = "Wood",
	tile      = itemDB["I3818BADB6A10DCFC,F63E89D9C91C3874,,,,,,"],
	rectangle = itemDB["I3818BADA6ED04521,10D72EFD29EF69EF,,,,,,"],
	plank     = itemDB["I3818BAD86D04D244,348BC924BC59DEB6,,,,,,"],
	cube      = itemDB["I3818BAD726D6F247,E9D76853DC14A2B4,,,,,,"],
	triangle  = itemDB["I3818BADC01097FD6,252511584FB0BA26,,,,,,"],
	pole      = itemDB["I3818BAD918BD92CD,FCFEF90E156F027F,,,,,,"],
	sphere    = itemDB["I6846DACA1918E2B7,3F9B19453FC10B42,,,,,,"],
	disc      = itemDB["I3E9A150B19634F49,3C9DF322C13AA502,,,,,,"]
}
skin["Dark Wood"] = {
	German    = "Dunkles Holz",
	French    = "Bois foncé",
	category  = "Wood",
	tile      = itemDB["I4390449D04E5F368,84B928CA65DE0EE0,,,,,,"],
	rectangle = itemDB["I56E5E8EA1EF90962,5D0746BF85DBFC23,,,,,,"],
	plank     = itemDB["I674D9B7F7947C364,489E1D34A1604689,,,,,,"],
	cube      = itemDB["I3B304F594D0FB5F3,12B734E4578639B3,,,,,,"],
	triangle  = itemDB["I3CAAAA3F72DEDC45,11A0FEE90A55ACEF,,,,,,"],
	pole      = itemDB["I160F9BC315C2E20F,B8E92ED42593AF20,,,,,,"],
	sphere    = itemDB["I13522A6F0C98AD5E,EFB4D69796ECAC6D,,,,,,"],
	disc      = itemDB["I0DFFF2E11EEDD6CB,311A4A2E29E699AC,,,,,,"]
}
skin["Greywood"] = {
	German    = "Grauholz",
	French    = "Bois gris",
	category  = "Wood",
	tile      = itemDB["I3818BACE65BAECAE,CB64CFBB2FE0F71C,,,,,,"],
	rectangle = itemDB["I391DEDC1145BB696,FBDDE244C8FF6361,,,,,,"],
	plank     = itemDB["I4CF0820D3C7CE954,721EF7930F0633C2,,,,,,"],
	cube      = itemDB["I391DEDC044825E6A,2C0F2BEF9496217D,,,,,,"],
	triangle  = itemDB["I3818BACF6A31F262,C8E7923BA3CEB795,,,,,,"],
	pole      = itemDB["I5061383166421B87,6A62D6F1ED761E9A,,,,,,"],
	sphere    = itemDB["I1D6F773153CDA645,526E57A293BC3A19,,,,,,"],
	disc      = itemDB["I3DF6E3CB3779FD8A,4ED9EC2055550794,,,,,,"]
}
skin["Mahogany Wood"] = {
	German    = "Mahagoniholz",
	French    = "Acajou",
	category  = "Wood",
	tile      = itemDB["I2B82E9F86386F5C0,33EF1DB6A44B749B,,,,,,"],
	rectangle = itemDB["I0A6CB1110E6DBA47,EAC71800AB74AAFD,,,,,,"],
	plank     = itemDB["I42EDA2E16662817E,24F3A09411280741,,,,,,"],
	cube      = itemDB["I52783D8A36AABA62,FA7291F9A70E2039,,,,,,"],
	triangle  = itemDB["I0809AD4A4A1DFC68,2794FDA3E50ABAD3,,,,,,"],
	pole      = itemDB["I01550B255430DCF5,DE4F028308A8A50C,,,,,,"],
	sphere    = itemDB["I085DEFBA22016E61,AFCB722569078453,,,,,,"],
	disc      = itemDB["I658E18495CEDCCC1,0C1822FFF7A3F839,,,,,,"]
}
skin["Oak Wood"] = {
	German    = "Eichenholz",
	French    = "Chêne",
	category  = "Wood",
	tile      = itemDB["I30BE36EC507BA0B1,5C09E2E3AE41C009,,,,,,"],
	rectangle = itemDB["I0AE383E32EB63261,C6E67030C0B8CEBA,,,,,,"],
	plank     = itemDB["I222B45C722A64D95,BBB199BC5DAE2D19,,,,,,"],
	cube      = itemDB["I48C073E50D8E8B13,FC4F01A4C3E21D6C,,,,,,"],
	triangle  = itemDB["I69E6D1E217E52D6D,0BFA324F11A2ED9E,,,,,,"],
	pole      = itemDB["I36B7E40766C21D76,369A1C2AEEFD41F3,,,,,,"],
	sphere    = itemDB["IFBE7167A6C70F946,2BEB309F51C0C3FB,,,,,,"],
	disc      = itemDB["I2522F217277071A5,2C7DBB5FA3227FDF,,,,,,"]
}
skin["Plain Wood"] = {
	German    = "Schlichtes Holz",
	French    = "Bois ordinaire",
	category  = "Wood",
	tile      = itemDB["IFE33236342049AFE,D721F224FC31EDF2,,,,,,"],
	rectangle = itemDB["IFF73FC9D69486DB4,369028719C371C12,,,,,,"],
	plank     = itemDB["IFA2C50EE0883B241,146F58B81707AFF4,,,,,,"],
	cube      = itemDB["IFD1D82C91B96FF04,2DE987CE7FA240C7,,,,,,"],
	triangle  = itemDB["I0E057DA426550772,4D553AB71D69591C,,,,,,"],
	pole      = itemDB["IFA78D5AE7889F999,4B12478968ABE5AB,,,,,,"],
	sphere    = itemDB["I40AC23860DF2E6E5,C349D19DBCDEF6A9,,,,,,"],
	disc      = itemDB["I3F8EE74E0D145C77,56C322D325A0A49A,,,,,,"]
}
skin["Wood Beam"] = {
	German    = "Holzbalken",
	French    = "Poutre en bois",
	category  = "Wood",
	tile      = itemDB["I40AC23891893C680,E2A013511D2CFD71,,,,,,"],
	rectangle = itemDB["I40AC238A1D97D570,BFA55E6FD970776E,,,,,,"],
	plank     = itemDB["I48810DEB3ED588C4,59BEB80B9B74C380,,,,,,"],
	cube      = itemDB["I40AC238B45C0D1CB,2043F0845228074B,,,,,,"],
	triangle  = itemDB["I785EE30E5A5C8EE5,2DDECF9329ACC08F,,,,,,"],
	pole      = itemDB["I5F86754D1DC031C7,448E5E6AF855D9AB,,,,,,"],
	sphere    = itemDB["I3EE00E2311A0E1B8,1411003D9E157F34,,,,,,"],
	disc      = itemDB["I7225C62478610192,13A8487ED267CDDE,,,,,,"]
}
-------------
-- Roofing --
-------------
skin["Blue Roof Tile"] = {
	German    = "Blaue Dachfliesen",
	French    = "Tuiles de toit bleu",
	category  = "Roof",
	tile      = itemDB["I3E35E8BC171BC10D,E28046BA0E806B77,,,,,,"],
	rectangle = itemDB["I06086BDB4FE45C5D,072C387D245670B4,,,,,,"],
	plank     = itemDB["I0F56765F226664F5,CB4EC024EFBD106A,,,,,,"],
	cube      = itemDB["I7F4510322733F3CC,63660851FA99C059,,,,,,"],
	triangle  = itemDB["I5262E04C162C741C,B9781A017A9B2430,,,,,,"],
	pole      = itemDB["I41093EAA71F5F2B3,A288DF9F6D7D9AF1,,,,,,"],
	sphere    = itemDB["IFA5DE89B75155960,72219625F23BC4BD,,,,,,"],
	disc      = itemDB["I324F5C5A29E9ED8A,E88EA3443492A74C,,,,,,"]
}
skin["Brown Shingle"] = {
	German    = "Braune Schindel",
	French    = "Bardeaux marron",
	category  = "Roof",
	tile      = itemDB["I25BC9D8B72566637,DAAA134487FBFA2D,,,,,,"],
	rectangle = itemDB["I0A65AAA93E0D4D64,5C0050F32CDD979C,,,,,,"],
	plank     = itemDB["I084A34F02B5C1FFC,199ADF952878802E,,,,,,"],
	cube      = itemDB["I4D462BB4051508F0,0FB9B0A064C39E45,,,,,,"],
	triangle  = itemDB["I4132735A4655AB9F,0DCF86FC541CE2C3,,,,,,"],
	pole      = itemDB["IFF269760414DCC14,396357B0227FEB1F,,,,,,"],
	sphere    = itemDB["I1828F3EC7322D944,363DEC99C2C358F1,,,,,,"],
	disc      = itemDB["I3A7BB8331C181B00,1F525F70F84F9BB6,,,,,,"]
}
skin["Green Scale Roof Tile"] = {
	German    = "Grüne Schuppendachfliesen",
	French    = "Tuiles de toit en écailles vertes",
	category  = "Roof",
	tile      = itemDB["I48B8AABB4842D25D,C44D674FB17E8A81,,,,,,"],
	rectangle = itemDB["I427CDFF94E65E1E2,EECEA89C2DB6B3A7,,,,,,"],
	plank     = itemDB["I57D52398015CF6D6,E3018CFDFC7CF093,,,,,,"],
	cube      = itemDB["I2FB10A5836BD72CB,01B138F90A42FA88,,,,,,"],
	triangle  = itemDB["I641BB490325917CD,03712E4901AAA7FD,,,,,,"],
	pole      = itemDB["I12638FC07DA799E5,A5DEAB23075ED77B,,,,,,"],
	sphere    = itemDB["I61A695E004E817AE,EEED4889A85B5E23,,,,,,"],
	disc      = itemDB["I5AE02A1C338F6C6D,29B4A0042732A46B,,,,,,"]
}
skin["Grey Scale Roof Tile"] = {
	German    = "Graue Schuppendachfliesen",
	French    = "Tuiles de toit en écailles grises",
	category  = "Roof",
	tile      = itemDB["I2AF349323B9AFF4E,EF41336E5DB10763,,,,,,"],
	rectangle = itemDB["I29FE763B5E7AB456,404DB270F3DA3529,,,,,,"],
	plank     = itemDB["I13194B5B4FF22CE8,F4ADB7FE0B42AEAE,,,,,,"],
	cube      = itemDB["I0AD62A123D46A66C,0169478A7EB29AEA,,,,,,"],
	triangle  = itemDB["I4BFB945E71789470,D2719C4AB7530DBC,,,,,,"],
	pole      = itemDB["I5552F6D52EDF1127,5E4E532811128582,,,,,,"],
	sphere    = itemDB["I462F2D2E7ACE7A58,FB9189ABA5A730A0,,,,,,"],
	disc      = itemDB["I2C046FC66B0EE399,1E175B72AB17967C,,,,,,"]
}
skin["Tin Sheet Roof"] = {
	German    = "Blechdach",
	French    = "Tôles de toiture en étain",
	category  = "Roof",
	tile      = itemDB["I77E07F3E45A432A8,61D8EC1625CB69C3,,,,,,"],
	rectangle = itemDB["I56850DD20C132D60,677E54C86C296D09,,,,,,"],
	plank     = itemDB["I50D79AF475F531D7,FEA06357B94719A3,,,,,,"],
	cube      = itemDB["I771F417C58FF966C,6E435A3032732634,,,,,,"],
	triangle  = itemDB["I72D9F4736DE7511F,AF4495716A75A7E0,,,,,,"],
	pole      = itemDB["I27D9CB3623DAE6F4,C210A8940B0164EB,,,,,,"],
	sphere    = itemDB["I6234450853DD60CD,189DBC0172AC58FB,,,,,,"],
	disc      = itemDB["I7A3BACFF7B548667,C6DDAF5A89928AE1,,,,,,"]
}
----------
-- Misc --
----------
skin["Rivited Metal"] = {
	German    = "Genietetes Metall",
	French    = "Métallique",
	category  = "Metal",
	tile      = itemDB["IFC4B896620716CD2,FB8EBAD1EF4F50C4,,,,,,"],
	rectangle = itemDB["IFC4B896518A1F73D,A9255B483DEAB8E9,,,,,,"],
	plank     = itemDB["IFC4B89636C1A7384,B74150E86591A10F,,,,,,"],
	cube      = itemDB["IFC4B89626946D626,16A12E12C6A58034,,,,,,"],
	triangle  = itemDB["I0E057DA266F01278,1362DC0D9B6FAF4D,,,,,,"],
	pole      = itemDB["IFC4B89642C2BE95C,B407349DADC528F9,,,,,,"],
	sphere    = itemDB["I40AC238873FE2176,0DBFC34FDAE24B48,,,,,,"],
	disc      = itemDB["I05D035633B0AA6B9,73A70FE1B9F24527,,,,,,"]
}
skin["Ice"] = {
	German    = "Eis",
	French    = "Glace",
	tile      = itemDB["I46DEDDFA1B1EF2B1,12B6DB6640573B89,,,,,,"],
	rectangle = itemDB["I1302EFA22521A21B,107FDE65CBEA718C,,,,,,"],
	plank     = itemDB["I6B59D27B2DC1132A,DA0832CD98B12A09,,,,,,"],
	cube      = itemDB["I70AAD55D7D382F63,CA0CA796136E401D,,,,,,"],
	triangle  = itemDB["I22A79B1D657B31D9,5A86827970176F3F,,,,,,"],
	pole      = itemDB["I3A506E305876407E,0DB1440928EBF6AA,,,,,,"],
	sphere    = itemDB["I6B41D47E7A06497D,15871F43AB87855A,,,,,,"],
	disc      = itemDB["I237032CF70B37A62,4138D47D4E39B99F,,,,,,"]
}
skin["Glass"] = {
	German    = "Glas",
	French    = "Verre",
	tile      = itemDB["I784602CE13838AA1,556EB47356AF6483,,,,,,"],
	rectangle = itemDB["I784602CA53E99F38,3256CF6227E0035F,,,,,,"],
	plank     = itemDB["I784602D01551C3CA,863977B44C6A4241,,,,,,"],
	cube      = itemDB["I784602D1145F1FA3,1C52D7225625EF23,,,,,,"],
	triangle  = itemDB["I784602CB07F3B04F,3333BB6F6E71EDB4,,,,,,"],
	pole      = itemDB["I784602CD40FD9F07,83D6DDA4B2346984,,,,,,"],
	sphere    = itemDB["I784602CF347BE7CF,15325962BAA314BC,,,,,,"],
	disc      = itemDB["I784602CC29D10429,6D0BBDC900615D14,,,,,,"]
}
skin["Matte Black"] = {
	German    = "Mattschwarz",
	French    = "Noir mat",
	tile      = itemDB["I21F02BCD3E046281,5BF69CFB2BA11883,,,,,,"],
	rectangle = itemDB["I02B3816417EF32DF,289F777337601F2B,,,,,,"],
	plank     = itemDB["I2FD487046088A2CC,4B09EC43ACD9314D,,,,,,"],
	cube      = itemDB["I36ADFE527B0ED047,0B3950FD135CDABE,,,,,,"],
	triangle  = itemDB["I3420F93A778D86DE,D5EF41A6CE1F6AAC,,,,,,"],
	pole      = itemDB["I372208105FB7713C,F97B6E2981527076,,,,,,"],
	sphere    = itemDB["I599DF6FA214429BA,F6D85025BA29A356,,,,,,"],
	disc      = itemDB["I3A29DB8F6CCB7C58,191811B1AB90E083,,,,,,"],
}
skin["Water"] = {
	German    = "Wasser",
	French    = "Eau",
	tile      = itemDB["I784602D650FF82A7,872E664CD3431A4B,,,,,,"],
	rectangle = itemDB["I784602D27EC61370,426904BD02C5B958,,,,,,"],
	plank     = itemDB["I784602D87B5DFCD4,3AE9E0465AF56A07,,,,,,"],
	cube      = itemDB["I784602D913007285,4949C035AC42DC57,,,,,,"],
	triangle  = itemDB["I784602D35A6C051F,546BDF208E228082,,,,,,"],
	pole      = itemDB["I784602D57AA4DCC1,4360FAB40A02EED5,,,,,,"],
	sphere    = itemDB["I784602D77AA6302D,37EE4478A3D4311F,,,,,,"],
	disc      = itemDB["I784602D41F00B39A,148CF9D4CF2F4694,,,,,,"]
}
skin["Water (No Collision)"] = {
	German    = "Wasser (keine Kollision)",
	French    = "Eau (sans collision)",
	tile      = itemDB["I783A11337F048555,4F30C26CC3945D5F,,,,,,"],
	rectangle = itemDB["IFB8E921A5AE404DD,D984FB1F8F968002,,,,,,"],
	plank     = itemDB["I694CB84065D70443,7D2F4E151A093742,,,,,,"],
	cube      = itemDB["I4E8218B3662200A6,24942046EA4B026B,,,,,,"],
	triangle  = itemDB["I791185A6354E63A1,EF1EBA549CC8CF54,,,,,,"],
	pole      = itemDB["I5BE9C17954CCAC68,1DE9D35FAFB1064B,,,,,,"],
	sphere    = itemDB["I1D712E3D3F5E47D3,D85C7D2BB13DB00F,,,,,,"],
	disc      = itemDB["I511B4EA1406AD6CA,B65FFFBCAB30AD86,,,,,,"]
}

Dta.Defaults.Skins = skin

Dta.Defaults.Skin_Categories = {
	{
		name = "All",
		German = "Alles",
		French = "Tous"
	},
	{
		name = "Wood",
		German = "Holz",
		French = "Bois"
	},
	{
		name = "Painted Wood",
		German = "Bemaltes Holz",
		French = "Bois peint"
	},
	{
		name = "Stone",
		German = "Stein",
		French = "Pierre"
	},
	{
		name = "Limestone",
		German = "Kalkstein",
		French = "Calcaire"
	},
	{
		name = "Brick",
		German = "Ziegel",
		French = "Brique"
	},
	{
		name = "Metal",
		German = "Metall",
		French = "Métal"
	},
	{
		name = "Roof",
		German = "Dach",
		French = "Toit"
	},
	{
		name = "Glowing",
		German = "Leuchtend",
		French = "Luminescent"
	},
	{
		name = "Miscellanious",
		German = "Sonstiges",
		French = "Divers"
	}
}

local category_lookup = {}

for i = 2, #Dta.Defaults.Skin_Categories do
	category_lookup[Dta.Defaults.Skin_Categories[i].name] = {}
end

-- integrity check and indexing
for name, skin_data in pairs(skin) do
	for shape, details in pairs(skin_data) do
		if type(details) == "table" and details.shape ~= shape then
			print("invalid skin entry:", name ..":" .. shape)
		end
	end
	local category = skin_data.category or "Miscellanious"
	if not category_lookup[category] then
		print("invalid skin category:", name .. ":" .. category)
		category = "Miscellanious"
	end
	category_lookup[category][name] = skin_data
end
-- first category is all skins
category_lookup[Dta.Defaults.Skin_Categories[1].name] = skins

Dta.Defaults.Skin_Category_Index = category_lookup
