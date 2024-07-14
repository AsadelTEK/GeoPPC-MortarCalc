def calculate_compressive_strength(P, A):
  """Menghitung kuat tekan mortar (f'c) dalam MPa.

  Args:
      P (float): Gaya tekan maksimum (N).
      A (float): Luas bidang tekan (mm^2).

  Returns:
      float: Kuat tekan mortar (MPa).
  """
  return P / A

def calculate_tensile_strength(Pt, A):
  """Menghitung kuat tarik mortar (fct) dalam MPa.

  Args:
      Pt (float): Gaya tarik maksimum (N).
      A (float): Luas bidang tarik (mm^2).

  Returns:
      float: Kuat tarik mortar (MPa).
  """
  return Pt / A

def calculate_density(M, V):
  """Menghitung densitas (T) dalam kg/m^3.

  Args:
      M (float): Massa benda uji (kg).
      V (float): Volume benda uji (m^3).

  Returns:
      float: Densitas (kg/m^3).
  """
  return M / V

def calculate_porosity(A, B, C):
  """Menghitung porositas dalam persen.

  Args:
      A (float): Berat sampel kering oven (gram).
      B (float): Berat sampel dalam air (gram).
      C (float): Berat sampel kondisi SSD (gram).

  Returns:
      float: Porositas (%).
  """
  return (C - A) / (C - B) * 100

def calculate_absorption(WT, W0, L1, L2):
  """Menghitung absorpsi dalam gram/100 cm^2.

  Args:
      WT (float): Berat benda uji pada waktu pengamatan (gram).
      W0 (float): Berat awal benda uji (gram).
      L1 (float): Panjang rata-rata permukaan benda uji (mm).
      L2 (float): Lebar rata-rata permukaan benda uji (mm).

  Returns:
      float: Absorpsi (gram/100 cm^2).
  """
  return (WT - W0) * 10000 / (L1 * L2)
