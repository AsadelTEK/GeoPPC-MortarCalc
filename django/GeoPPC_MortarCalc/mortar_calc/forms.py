from django import forms
from .models import MaterialData

class MaterialDataForm(forms.ModelForm):
    class Meta:
        model = MaterialData
        fields = ['fly_ash', 'tanah_putih', 'naoh', 'air', 'pasir']
