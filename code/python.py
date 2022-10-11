def f(n):
    if n < 3:
        return n
    elif n >= 3:
        return f(n-1) + (2 * f(n-2)) + (3 * f(n-3))


def g(n):
    if n < 3:
        return n

    f1 = 2
    f2 = 1
    f3 = 0
    m = 0
    while m < n:
        fnew = f1 + 2 * f2 + 3 * f3
        f3 = f2
        f2 = f1
        f1 = fnew
        m = m + 1
    return f3


def test(n):
    a = f(n)
    b = g(n)
    print(f"f({n})= {a}", end="\t")
    print(f"g({n}) = {b}", end="\t")
    print(f"Test passed: {a==b}")


if __name__ == "__main__":

    for i in range(10):
        test(i)
