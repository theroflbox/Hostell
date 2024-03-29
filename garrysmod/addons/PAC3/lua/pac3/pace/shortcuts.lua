
function pace.OnCloseEditor()
	pace.EnableView(false)
	pace.StopSelect()
	pace.SafeRemoveSpecialPanel()
end

function pace.OnShortcutSave()
	if pace.current_part:IsValid() then
		local part = pace.current_part:GetRootPart()
		pace.SavePartToFile(part, part:GetName())
		surface.PlaySound("buttons/button9.wav")
	end
end

function pace.OnShortcutWear()
	if pace.current_part:IsValid() then
		local part = pace.current_part:GetRootPart()
		pac.SendPartToServer(part)
		surface.PlaySound("buttons/button9.wav")
	end
end

local last = 0

function pace.CheckShortcuts()
	if pace.Editor and pace.Editor:IsValid() then
		if last > CurTime() or input.IsMouseDown(MOUSE_LEFT) then return end

		if input.IsKeyDown(KEY_LCONTROL) and input.IsKeyDown(KEY_M) then
			pace.Call("ShortcutSave")
			last = CurTime() + 0.2
		end
		
		if input.IsKeyDown(KEY_LCONTROL) and input.IsKeyDown(KEY_N) then
			pace.Call("ShortcutWear")
			last = CurTime() + 0.2
		end
		
		if input.IsKeyDown(KEY_LCONTROL) and input.IsKeyDown(KEY_E) then
			pace.Call("ToggleFocus")
			last = CurTime() + 0.2
		end
		
		if input.IsKeyDown(KEY_LALT) and input.IsKeyDown(KEY_E) then
			pace.Call("ToggleFocus", true)
			last = CurTime() + 0.2
		end
	end
end

hook.Add("Think", "pace_shortcuts", pace.CheckShortcuts)