class Terminal {
	idd = 1;
	type = CT_COMBO;
	movingenable = false;
	name = "Terminal";
	class controls {
		class Nest0 : HB_Controls_Group {
			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW;
			h = safeZoneH;
			class controls {
				class Console{
					idc = 101;
					type = 0;
					x = 0;
					y = 0;
					h = 1024;
					w = SafeZoneW;
					sizeEx = 0.03;
					colorBackground[] = {0,0,0,1};
					colorText[] = {0,1,0,1};
					text = "";
					font = "EtelkaMonospacePro";
					style = ST_MULTI;
					lineSpacing = 1;
				};
			};
		};
	};
};

class Editor {
	idd = 2;
	type = CT_COMBO;
	movingenable = false;
	name = "Editor";
	class controls {
		class Nest1 : HB_Controls_Group {
			x = safeZoneX;
			y = safeZoneY;
			w = safeZoneW;
			h = safeZoneH;
			class controls {
				class Steed{
					idc = 101;
					type = 0;
					x = 0;
					y = 0;
					h = 1024;
					w = SafeZoneW;
					sizeEx = 0.03;
					colorBackground[] = {0,0,0,1};
					colorText[] = {0,1,0,1};
					text = "";
					font = "EtelkaMonospacePro";
					style = ST_MULTI;
					lineSpacing = 1;
				};
			};
		};
	};
};