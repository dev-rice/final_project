BoxCollider = {}
BoxCollider.__index = BoxCollider

function BoxCollider.create(x1, y1, x2, y2)
	box_collider = {}
	setmetatable(box_collider, BoxCollider)

	box_collider.x1 = x1
	box_collider.x2 = x2
	box_collider.y1 = y1
	box_collider.y2 = y2

	box_collider.width = box_collider.x2 - box_collider.x1
	box_collider.height = box_collider.y2 - box_collider.y1

	box_collider.tolerance = 5

	return box_collider
end

function BoxCollider:draw()

	r, g, b, a = love.graphics.getColor()

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("line", self.x1, self.y1, self.width + 1, self.height + 1)

	love.graphics.setColor(r, g, b, a)
end

function BoxCollider:hit_vertical(x1, y1, x2, y2)
	if (y1 > self.y2) or (y2 < self.y1) then
		return false
	end

	return self:in_tolerance(x2, self.x2) or self:in_tolerance(x1, self.x1) or 
		self:in_tolerance(x1, self.x2) or self:in_tolerance(x2, self.x1)
end

function BoxCollider:hit_horizontal(x1, y1, x2, y2)
	if (x1 > self.x2) or (x2 < self.x1) then
		return false
	end

	return self:in_tolerance(y2, self.y2) or self:in_tolerance(y2, self.y1) or
		self:in_tolerance(y1, self.y2) or self:in_tolerance(y1, self.y1)
end

function BoxCollider:in_tolerance(a, b)
	return math.abs(a-b) <= self.tolerance
end

function BoxCollider:move(x, y)
	self.x1 = x
	self.y1 = y
	self.x2 = x + self.width
	self.y2 = y + self.height
end