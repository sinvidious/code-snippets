local stateMeta = {get = function(self) return self.value end, set = function(self,input)
	self.value = input
end,}

local stateClass = function(input)
	return setmetatable({value = input}, {__index = stateMeta})
end

local computedClass = function(callback)
	return {get = callback}
end

local FirstDataSet = stateClass {
	{0,0,1},
	{0,2,0},
	{3,0,0}
}

local ComputedDataSet = computedClass(function()
	local NewState = {}
	for SingleIndex, SingleSet in ipairs(FirstDataSet:get()) do
		NewState[SingleIndex] = {}
		for _, singlePoint in ipairs(SingleSet) do
			table.insert(NewState[SingleIndex], singlePoint * 10)
		end
	end
	
	return NewState
end)

local function printUpdate(adString,object)
	local finalstring = "{"
	for _, SingleSet in ipairs(object:get()) do
		finalstring = finalstring.."{"
		for _, singlePoint in ipairs(SingleSet) do
			finalstring = finalstring..singlePoint..","
		end
		finalstring = finalstring.."},"
	end
	finalstring = finalstring.."}"
	
	print(adString,finalstring)
end

printUpdate("State",FirstDataSet)
printUpdate("Computed",ComputedDataSet)
FirstDataSet:set({
	{0,0,10},
	{0,20,0},
	{30,0,0}
})
print("_________")
printUpdate("State",FirstDataSet)
printUpdate("Computed",ComputedDataSet)
