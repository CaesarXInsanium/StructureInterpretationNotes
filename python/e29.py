def cube(x):
    return x * x * x

def simpson_integral(f, a, b, n):
    h = (b - a) / n

    def sum(term, a, next, b):
        if a > b:
            return 0
        else:
            return term(a) + sum(term, next(a), next, b)

    def term(x):
        return f(x) + (4 * f(x + h)) + f(x + 2 * h)

    def next(x):
        return x + (2 * h)
    return (h / 3) * sum(term, a, next, b - (2 * h))

simpson_integral(cube, 0, 1, 1000)
