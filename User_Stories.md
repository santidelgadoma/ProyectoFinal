# User Stories para VoxxMap

VoxxMap es una empresa encargada de ofrecer soluciones para el bien público a través del análisis de datos y la participación ciudadana. En esta ocasión VoxxMap busca, por medio de encuestas, combatir la crisis mundial que se esta viviendo a causa del COVID-19.


**Epic Story: Como VoxxMap quiero levantar datos de los hospitales para poder analizarlos**

1. **Formular la Encuesta** Como VoxxMap quiero poder tener los datos necesarios de cada hospital sin importar lo remoto que sea el lugar en el que se ubique. Los datos se obtendrán a partir de un Google Forms con preguntas específicas al igual que datos geográficos del hospital.
2. **Organización de Datos** Como VoxxMap necesito poder integrar los resultados obtenidos en una base de datos para poder organizarla y hacer buen uso de la información recopilada.

**Epic Story: Como VoxxMap quiero tener una base de datos confiable y flexible, para poder guardar y actualizar información.**

1. **Creación de la Base de Datos** Como Voxxmap requiero de una base de datos confiable para poder levantar reportes con el menor ruido posible. Debe cumpla con las reglas de normalización utilizando las mejores prácticas.
2. **Establecer Conexión a la Base de Datos** Como VoxxMap necesito que las respuestas de la encuesta se reflejen en la base de datos a través de una conexión automatizada para tener la información siempre actualizada.

**Epic Story: Como VoxxMap requiero de un ánalisis de los datos de los hospitales**

1. **Ánalisis de Datos con Funciones de PostgreSQL** Como VoxxMap deseo obtener conclusiones a partir de la información obtenida que sea valiosa para llevar a cabo el análisis.
2. **Monitoreo de Hospitales con Información Incompleta** Como VoxxMap quiero saber qué hospitales deben  ser contactados otra vez para llenar vacíos que permitan un mayor alcance del proyecto.
3. **Presentación de Tableros Gráficos** Como VoxxMap deseo poder ver presentaciones con tableros gráficos de la información analizada para poder tener un apoyo visual de los problemas que se presentan.

# Problem Domain

El alcance de Voxxmap es global, por lo que ciertas regiones en las que se opera presentan retos adicionales. En el caso de los países en vías de desarrollo, existen limitantes sociales, tecnológicas y económicas. 

1. **Falta de infraestructura** Muchas regiones del mundo (medio oriente, latinoamérica, África y el sureste de Asia) no cuentan con la infraestructura adecuada para el levantamiento de datos. Se debe tener en cuenta que la aplicación en la que se maneja la encuesta debe ser lo más ligera posible y debe poder operar en circunstancias subóptimas. Voxxmap pretende brindar esta infraestructura remotamente, permitiendo un registro de datos seguro y eficiente.  
2. **Falta de conocimiento** En los países en que no se cuenta con infraestructura gubernamental para el monitoreo de los patógenos como el COVID-19, la población general está menos informada y por ende la participación ciudadana tiende a ser más débil. La falta de recursos estatales implica además un vacío de información en los hospitales públicos, en donde los registros no son de fiar. El objetivo de Voxxmap en este ámbito es generar visiones alternas a las oficiales; además de levantar datos, se generarán vistas analíticas que permitan a los hospitales tomar decisiones y ejecutar sus planes de acción.  
3. **Limitado acceso a la tecnología** Gran parte de la población de los países en vías de desarrollo no tiene un acceso continuo a la dispositivos electrónicos; por ende, le tecnología social tiene un alcance limitado en estas regiones. Voxxmap no puede asumir que las encuestas pueden ser respondidas por cualquiera, ni que todos cuentan con dispositivos capaces de correr un programa de encuestado. Se debe asumir que en los hospitales a los que se contacta se cuenta por lo menos con una computadora capaz de abrir una encuesta sencilla, pero siempre tomando en cuenta que puede sólo haber uno y que puede no tener una conexión de internet estable. Voxxmap combatirá estas limitantes brindando la encuesta de manera telefónica en los lugares que no cuenten con dispositivos capaces y desplegando encuestas digitales ligeras. 
4. **Falta de colaboración social** Además de la nula colaboración estatal, las regiones más desfavorecidas también tienen poblaciones menos dispuestas a colaborar en proyectos de este estilo. Ya sea porque no conocen los detalles que se les preguntan o porque simplemente no quieren contestar, es una cuestión que se debe tomar en cuenta. Posiblemente dos contactos con el mismo hospital puedan rendir resultados distintos dependiendo de quién conteste la llamada o la encuesta en cada ocasión. Esto se enfrentará a través de un análisis consolidador y conciliador entre los resultados distintos que arroja cada intento de encuesta en un hospital determinado.  



