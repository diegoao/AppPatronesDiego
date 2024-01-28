
# Práctica Patrones de diseño

Práctica realizada para el módulo de Patrones de diseño por Diego Andrades.

**KeepCoding - Profesor Aitor.**

<<Importante.- En este caso basamos la estructura de la aplicaión en "MVVM">>
El proyecto trata de una App enfocada en DragonBall con la cual realizamos una conexión a una API y visualizamos sus datos.





## API Reference

#### Obtener todos los items

```http
  https://dragonball.keepcoding.education/api/heros/
```

## Información

La práctica consta de varias pantallas:
| ![Simulador1](https://github.com/diegoao/AppPatronesDiego/blob/main/AppPatronesDiego/appCaptures/Splash.png) | ![Simulador2](https://github.com/diegoao/AppPatronesDiego/blob/main/AppPatronesDiego/appCaptures/Login.png) | ![Simulador3](https://github.com/diegoao/AppPatronesDiego/blob/main/AppPatronesDiego/appCaptures/Heroes.png) | ![Simulador4](https://github.com/diegoao/AppPatronesDiego/blob/main/AppPatronesDiego/appCaptures/Detail.png) |
| --- | --- | --- | --- | 
| 1 | 2 | 3 | 4 | 

```
1. Splash -> Pantalla de inicio mientras se carga la
App.
```
```
2. Login -> Pantalla en la cual tenemos que logearnos.
Previamente tenemos que crearnos un usuario en la API. Si
obtenemos un error al ingresar el usuario o contraseña nos
saldrá un mensage de error. Si iniciamos sesion no volverá
a salir hasta que pulsemos el botón logOut!
```
```
3. Lista de héroes -> Al obtener el token con nuestro usuario
y contraseña accederemos a la lista de héroes donde podremos
ver todos los personajes incluidos en la Api. Al realizar clic
sobre ellos se nos abrirá la pantalla de Detalles.
```
```
4. Detalles -> Podemos ver la foto y una descripción del héroe.
```
```

## Autor

- [@Diego](https://github.com/diegoao)
