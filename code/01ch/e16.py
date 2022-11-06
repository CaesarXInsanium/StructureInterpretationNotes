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


def g(b, n):
    m = n
    result = b
    if n == 0:
        return 1
    elif b == 0:
        return 0
    elif n == 1:
        return b
    elif n == 2:
        return square(b)
    else:
        while m != 1:
            print(f"m = {m}, result = {result}", end="\t")
            if even(m):
                result = square(b) * result
                m = int(m / 2)
            else:
                result = b * result
                m = m - 1
            print(f"m = {m}, result = {result}")
    return result



def iter_fast_expt( b ,n):
    def iter(N, B , A):
        if n == 0:
            return A
        elif even(n):
            return iter(n / 2, square(B), A)
        else:
            iter(n -1, B, B * A)
    return iter(n,b,1)

def big_test(r):
    for b in range(r):
        for n in range(r):
            result = iter_fast_expt(b, n)
            correct = pow(b, n)
            print(f"b = {b}, n = {n}\tresult = {result}\tcorect = {correct}")
            assert(correct == result)
            

if __name__ == "__main__":
        
    big_test(10)
