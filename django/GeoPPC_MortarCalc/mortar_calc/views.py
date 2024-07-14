from django.shortcuts import render, redirect
from .forms import MaterialDataForm
from .models import MaterialData, CalculationResult

def calculate_mechanical_properties(data):
    fly_ash = float(data.fly_ash)
    tanah_putih = float(data.tanah_putih)
    naoh = float(data.naoh)
    air = float(data.air)
    pasir = float(data.pasir)

    compressive_strength = fly_ash * 1.5
    tensile_strength = tanah_putih * 2.0
    porosity = naoh * 0.1
    density = air * 1.1
    absorption = pasir * 0.05
    return compressive_strength, tensile_strength, porosity, density, absorption

def material_data_create(request):
    if request.method == 'POST':
        form = MaterialDataForm(request.POST)
        if form.is_valid():
            material_data = form.save()
            compressive_strength, tensile_strength, porosity, density, absorption = calculate_mechanical_properties(material_data)
            CalculationResult.objects.create(
                material_data=material_data,
                compressive_strength=compressive_strength,
                tensile_strength=tensile_strength,
                porosity=porosity,
                density=density,
                absorption=absorption
            )
            return redirect('result', pk=material_data.pk)
    else:
        form = MaterialDataForm()
    return render(request, 'mortar_calc/material_data_form.html', {'form': form})

def calculation_result(request, pk):
    result = CalculationResult.objects.get(material_data__pk=pk)
    return render(request, 'mortar_calc/calculation_result.html', {'result': result})

def dashboard(request):
    return render(request, 'mortar_calc/dashboard.html')
