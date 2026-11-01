class_name Utils;

static func avg(arr: Array[float]) -> float:
	var total = 0;
	for x in arr:
		total += x;
		
	return total / len(arr);

static func temp_curve(x: float, k: float, m: float) -> float:
	var a = 1.0 / (1.0 + exp(-k * x))
	return m * (a - 0.5)
