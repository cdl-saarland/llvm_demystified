#include <bit>
#include <iostream>

std::uint32_t divide(std::uint32_t N, std::uint32_t D) {
    std::uint32_t Q = 0;
    auto align = std::countl_zero(D) - std::countl_zero(N);
    D <<= align;
    for (int i = 0, num = 32 - std::countl_zero(N); i < num; ++i) {
        std::int64_t t = static_cast<std::int64_t>(N) - D;
        if (t >= 0) {
            Q |= 1;
            N = t;
        }
        N <<= 1;
        Q <<= 1;
    }
    Q >>= align;
    return Q;
}

std::uint32_t multiply(std::uint32_t A, std::uint32_t B) {
    auto acc = 0;
    for(int i = 0; i < B; ++i) {
        acc += A;
    }
    return acc;
}

int main(int argc, const char* argv[]) {
    if (argc < 3) return -1;
    std::uint64_t a = std::atoll(argv[1]), b = std::atoll(argv[2]);
    std::cout << a << " / " << b << " = " << a / b << "\n";
    auto res = divide(a, b);
    std::cout << "divide(" << a << ", " << b << ") = " << res << "\n";
    std::cout << a << " * " << b << " = " << a * b << "\n";
    auto mul_res = multiply(a, b);
    std::cout << "multiply(" << a << ", " << b << ") = " << mul_res << "\n";
    return 0;
}
