def square(n):
    return n * n


def even(n):
    return n % 2 == 0


def f(b, n):
    if n == 0:
        return 1
    elif n == 1:
        return n
    elif n == 2:
        return square(b)
    elif even(n):
        return f(square(b), n / 2)
    else:
        return b * f(b, n-1)


def test(b, n):
    correct = pow(b, n)
    recursive = f(b, n)
    print(f"Corect: {correct}\tRecursive: {recursive}")


if __name__ == "__main__":
    test(2, 2)
    test(2, 0)
    test(4, 5)
    test(4, 3)
    test(1, 9)
