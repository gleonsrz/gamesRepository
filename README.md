# gamesRepository
 
En este archivo se explica un poco de las decisiones tomadas para el presente proyecto

El propósito de este proyecto es mostrar de forma efectiva una serie de juegos que son obtenidos a través de una API pública, garantizar su visualización de acuerdo a una serie de requerimientos y lograr persistir información para garantizar que se muestre algo en caso de que la conexión a internet no se encuentre disponible en algún momento.

Para esto, se implementó el proyecto con la arquitectura MVVM con combine. Esto debido a que el patrón de arquitectura permite la separación de responsabilidades, lo que mejora la organización del código, el mantenimiento y la escalabilidad del proyecto. Por otra parte, Combine permite la reactividad, es decir le da al proyecto la capacidad de actualizarse automáticamente cuando los datos cambian sin necesidad de manipular directamente la interfaz del usuario. De la misma manera, esta arquitectura facilita la implementación de pruebas unitarias debido a que no está acoplada a la vista como tal.

Por el lado de la persistencia, se utilizó Realm manejado mediante Swift Package Manager, el cual almacena la información cuando el usuario lo determina cuando le da tap al corazón de favoritos en el detalle del videojuego. Cabe resaltar que para ingresar a este detalle es necesario que el usuario de tap al ícono de información en la celda y no en cualquier parte de la celda. Igualmente, si el usuario deselecciona este corazón, la información es borrada de Realm. Cabe resaltar que no es necesario que el usuario vaya al detalle para recién remover un favorito, este puede deslizar hacia el costado el favorito que desea eliminar y al darle a la opción eliminar (o deslizando completamente) podrá eliminarlo del listado igualmente. 

Por último, para ejecutar la aplicación solo es necesario clonar el proyecto y compilarlo dentro de un teléfono físico o emulador de XCode y se podrá probar todo lo que se mencionó anteriormente.
