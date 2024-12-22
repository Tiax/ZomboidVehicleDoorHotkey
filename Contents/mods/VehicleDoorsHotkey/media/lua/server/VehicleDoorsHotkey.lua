-- server\VehicleDoorsHotkey.lua
--require "Vehicles\Vehicles" -- for VehicleUtils

VehicleDoorsHotkey = {}
VehicleDoorsHotkey.originalUseVehicle = VehicleUtils.OnUseVehicle

-- Overwrite this function
VehicleDoorsHotkey.OnUseVehicle = function (character, vehicle, pressedNotTapped)
  --print(string.format("VehicleDoorsHotkey.OnUseVehicle[%s]", tostring(pressedNotTapped)))
  
  if (isKeyDown(42) or isKeyDown(54)) then -- LSHIFT/RSHIFT, see lwjgl codes
    -- shift is pressed, open/close door instead of entering/exiting
    local doorPart = vehicle:getUseablePart(character)
    
    if doorPart and doorPart:getDoor() and doorPart:getInventoryItem() then
      if doorPart:getDoor():isOpen() then
        ISVehicleMenu.onCloseDoor(character, doorPart)
      else
        ISVehicleMenu.onOpenDoor(character, doorPart)
      end
    end
  else
    VehicleDoorsHotkey.originalUseVehicle(character, vehicle, pressedNotTapped)
  end
end

Events.OnUseVehicle.Remove(VehicleUtils.OnUseVehicle)
Events.OnUseVehicle.Add(VehicleDoorsHotkey.OnUseVehicle)
