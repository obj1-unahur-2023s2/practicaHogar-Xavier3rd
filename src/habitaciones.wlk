import personas.*

class Habitacion {
	
	var nivelDeConfort = 10
	const property ocupantes = #{}
		
	method nivelDeConfort(unaPersona) = nivelDeConfort
	
	// Metodos para entrar a la habitación
	method entrarALaHabitacion(unaPersona){
		ocupantes.add(unaPersona)
	}
	method salirDeLaHabitacion(unaPersona){
		ocupantes.remove(unaPersona)
	}	
	
}


class UsoGeneral inherits Habitacion {
	
}

class Banio inherits Habitacion {
	override method nivelDeConfort(unaPersona) = 
		if (unaPersona.edad() <= 4 ){
			super(unaPersona) + 2
		}
		else {
			super(unaPersona) + 4
		} 
		
	// Metodos para entrar a la habitación
	method hayAlgunOcupanteMenorDe4Anios() = 
		ocupantes.any({o => o.edad() <= 4})
	
	override method entrarALaHabitacion(unaPersona){
		if (self.hayAlgunOcupanteMenorDe4Anios()){ 
			super(unaPersona)
		}
	}
}

class Dormitorio inherits Habitacion {
	const property estan = []
	const property duermen = [] 

	method cantidadDePersonasQueEstan() = estan.size()	
	method cantidadDePersonasQueDuermen() = duermen.size()
	method duermeEnElDormitorio(unaPersona) = duermen.find({p => p == unaPersona})
	
	override method nivelDeConfort(unaPersona) =
		if (self.duermeEnElDormitorio(unaPersona)){
			super(unaPersona) + 10/self.cantidadDePersonasQueDuermen()
		} 
		else {
			super(unaPersona)
		}
}

class Cocina inherits Habitacion {
	
	const m2 
	
	method procentajeDeM2DeLaCocina() = m2 + porcentaje.m2()
	
	override method nivelDeConfort(unaPersona) =
		
		if(unaPersona.tieneHabilidadesCulinarias()){
			super(unaPersona) + self.procentajeDeM2DeLaCocina() 
		}
		else {
			super(unaPersona)
		}
	
	// Metodos para entrar a la habitación
	method hayAlguienQueSepaCocinar() = 
		ocupantes.any({o => o.tieneHabilidadesCulinarias()})
	
	override method entrarALaHabitacion(unaPersona){
		if (unaPersona.tieneHabilidadesCulinarias() and !self.hayAlguienQueSepaCocinar()){ 
			super(unaPersona)
		}
	}
}

object porcentaje {
	method m2() = 0.1
}
