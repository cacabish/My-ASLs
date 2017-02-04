/*
 * Release Version 1.1
 * Coded by cacabish. Please do not claim as your own.
 */

state("Battleship2") {
	int levelTime : 0x7B4188;
	bool isPaused : 0x081A44;
	int levelNumber : 0x7B4D70;
	bool inLevel : 0x10778C;
	bool levelComplete : 0x7B4218;
	bool mainMenu : 0x09B4FC;
}

start {
	vars.gameTime = TimeSpan.Zero;
	return settings.StartEnabled && current.inLevel;
}

split {
	if (!old.levelComplete && current.levelComplete) {
		if (settings.SplitEnabled) {
			if (settings["levelSplit"]) {
				return true;
			}
			else {
				return current.levelNumber == 19;
			}
		}
	}
}

reset {
	return current.mainMenu;
}

update {
	if (old.levelTime > 0 && current.levelTime == 0) {
		vars.gameTime += TimeSpan.FromMilliseconds(old.levelTime);
	}
}

isLoading {
	return current.isPaused || !current.inLevel;
}

gameTime {
	return vars.gameTime + TimeSpan.FromMilliseconds(current.levelTime);
}

startup {
	settings.Add("levelSplit", true, "Level Splits");
	settings.SetToolTip("levelSplit", "Auto-splits after completing each level.");
}