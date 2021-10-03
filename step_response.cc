#include <cmath>
#include <cstddef>
#include <fstream>
#include <utility>

#include <nlohmann/json.hpp>
#include <transfer_function/TrivialTransferFunction.h>

int main(int argc, char** argv) {
  TrivialTF<1> controller([](TrivialTF<1>::input v) -> TrivialTF<1>::output {
    static wpi::array<double, 1> s = {0.0};
    for (std::size_t i = 0; i < 1; ++i) {
      if (std::abs(v[i] - s[i]) > 0.2) {
        s[i] = v[i] = 0.9 * s[i] + 0.1 * v[i]; 
      } else if (std::abs(v[i] - s[i]) > 0.02) {
        s[i] = v[i] = s[i] + std::copysign(0.02, v[i] - s[i]);
      } else {
        s[i] = v[i];
      }
    }
    return std::move(v);
  });

  nlohmann::json result;

  double dt = 1.0 / 100.0;
  for (double t = 0.0; t < 0.5; t += dt) {
    result.push_back({t, 1.0, (wpi::array<double, 1>{1.0} * controller)[0]});
  }

  std::ofstream fout("build/step_response.json");
  fout << result;
  fout.close();

  return 0;
}