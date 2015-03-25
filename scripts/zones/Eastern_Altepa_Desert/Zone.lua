-----------------------------------
--
-- Zone: Eastern_Altepa_Desert (114)
--
-----------------------------------
package.loaded["scripts/zones/Eastern_Altepa_Desert/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Eastern_Altepa_Desert/TextIDs");
require( "scripts/globals/icanheararainbow");
require("scripts/globals/zone");
require("scripts/globals/conquest");

-----------------------------------
-- Chocobo Digging vars
-----------------------------------
local itemMap = {
                    -- itemid, abundance, requirement
                    { 880, 167, DIGREQ_NONE }, 
                    { 893, 88, DIGREQ_NONE }, 
                    { 17296, 135, DIGREQ_NONE },
                    { 736, 52, DIGREQ_NONE },
                    { 644, 22, DIGREQ_NONE },
                    { 942, 4, DIGREQ_NONE },
                    { 738, 12, DIGREQ_NONE },
                    { 866, 36, DIGREQ_NONE },
                    { 642, 58, DIGREQ_NONE },
                    { 574, 33, DIGREQ_BURROW },
                    { 575, 74, DIGREQ_BURROW },
                    { 572, 59, DIGREQ_BURROW },
                    { 1237, 19, DIGREQ_BURROW },
                    { 573, 44, DIGREQ_BURROW },
                    { 2235, 41, DIGREQ_BURROW },
                    { 646, 3, DIGREQ_BORE },
                    { 678, 18, DIGREQ_BORE },
                    { 645, 9, DIGREQ_BORE },
                    { 768, 129, DIGREQ_BORE },
                    { 737, 3, DIGREQ_BORE },
                    { 739, 3, DIGREQ_BORE },
                    { 4570, 10, DIGREQ_MODIFIER },
                    { 4487, 11, DIGREQ_MODIFIER },
                    { 4409, 12, DIGREQ_MODIFIER },
                    { 1188, 10, DIGREQ_MODIFIER },
                    { 4532, 12, DIGREQ_MODIFIER },
                };

local messageArray = { DIG_THROW_AWAY, FIND_NOTHING, ITEM_OBTAINED };

-----------------------------------
-- onChocoboDig
-----------------------------------
function onChocoboDig(player, precheck)

    -- Let's get the weather of the zone

    local weather = player:getWeather();

    if (weather ~= nil) then
      if (weather >= 0 and weather <= 4) then
        zoneWeather = "WEATHER_NONE";
      elseif (weather > 4 and weather % 2 ~= 0) then -- If the weather is 5, 7, 9, 11, 13, 15, 17 or 19, checking for odd values
        zoneWeather = "WEATHER_DOUBLE";
      else
        zoneWeather = "WEATHER_SINGLE";
      end
    else
      zoneWeather = "WEATHER_NONE";
    end
    
    return chocoboDig(player, itemMap, precheck, messageArray, zoneWeather);
end;

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
    local manuals = {17244653,17244654,17244655};

    SetFieldManual(manuals);

    -- Cactrot Rapido
    SetRespawnTime(17244539, 900, 10800);

    -- Centurio XII-I
    SetRespawnTime(17244372, 900, 10800);

    SetRegionalConquestOverseers(zone:getRegionID())
end;

-----------------------------------
-- onConquestUpdate
-----------------------------------

function onConquestUpdate(zone, updatetype)
    local players = zone:getPlayers();

    for name, player in pairs(players) do
        conquestUpdate(zone, player, updatetype, CONQUEST_BASE);
    end
end;

-----------------------------------
-- onZoneIn
-----------------------------------

function onZoneIn( player, prevZone)
    local cs = -1;

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos( 260.09, 6.013, 320.454, 76);
    end

    if (triggerLightCutscene(player)) then -- Quest: I Can Hear A Rainbow
        cs = 0x0002;
    end

    return cs;
end;

-----------------------------------
-- onRegionEnter
-----------------------------------

function onRegionEnter( player, region)
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate( player, csid, option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 0x0002) then
        lightCutsceneUpdate(player); -- Quest: I Can Hear A Rainbow
    end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish( player, csid, option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 0x0002) then
        lightCutsceneFinish(player); -- Quest: I Can Hear A Rainbow
    end
end;