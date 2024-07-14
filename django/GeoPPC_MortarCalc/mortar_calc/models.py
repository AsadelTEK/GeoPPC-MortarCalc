from django.db import models

class MaterialData(models.Model):
    fly_ash = models.DecimalField(max_digits=5, decimal_places=2)
    tanah_putih = models.DecimalField(max_digits=5, decimal_places=2)
    naoh = models.DecimalField(max_digits=5, decimal_places=2)
    air = models.DecimalField(max_digits=5, decimal_places=2)
    pasir = models.DecimalField(max_digits=5, decimal_places=2)

class CalculationResult(models.Model):
    material_data = models.OneToOneField(MaterialData, on_delete=models.CASCADE)
    compressive_strength = models.DecimalField(max_digits=8, decimal_places=2)
    tensile_strength = models.DecimalField(max_digits=8, decimal_places=2)
    porosity = models.DecimalField(max_digits=5, decimal_places=2)
    density = models.DecimalField(max_digits=8, decimal_places=2)
    absorption = models.DecimalField(max_digits=5, decimal_places=2)
