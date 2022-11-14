def mul(a, b):
    if b == 0:
        return 0
    else:
        return a + (mul(a, b -1))

def muli(a,b):
    p = 1
    while b != 0:
        p = a + (p-1) 
        b = b -1
    return p

def test(n):
    for i in range(n):
        for j in range(n):
            correct = i * j
            answer = muli(i,j)
            print(f"i={i}\tj={j}\tcorrect={correct}\tanswer={answer}\tcorrect?={correct==answer}")

if __name__ == "__main__":
   test(10) 
