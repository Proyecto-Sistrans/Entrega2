# IPSAndes Application

IPSAndes es una aplicación desarrollada en Java utilizando Spring Boot y Oracle Database. Esta aplicación permite gestionar servicios de salud, agendas, órdenes médicas, afiliados, médicos, y más.

## Requisitos previos

Antes de instalar y ejecutar la aplicación, asegúrate de tener los siguientes requisitos instalados en tu sistema:

1. **Java Development Kit (JDK)**: Versión 21 o superior.
2. **Apache Maven**: Para gestionar las dependencias y construir el proyecto.
3. **Oracle Database**: Una base de datos Oracle configurada y accesible.
4. **IDE**: Se recomienda usar [Visual Studio Code](https://code.visualstudio.com/) o cualquier IDE compatible con Java.
5. **Git**: Para clonar el repositorio (opcional).

## Configuración de la base de datos

1. Crea una base de datos en Oracle.
2. Ejecuta el script SQL ubicado en [`docs/BaseDatosPROYECTO.sql`](docs/BaseDatosPROYECTO.sql) para crear las tablas necesarias.
3. (Opcional) Población inicial: Ejecuta el script SQL ubicado en [`docs/PoblacionEPSAndes (1).sql`](docs/PoblacionEPSAndes%20(1).sql) para insertar datos de prueba.

## Configuración de la aplicación

1. Abre el archivo [`src/main/resources/application.properties`](src/main/resources/application.properties).
2. Configura las credenciales de conexión a la base de datos Oracle:
   ```properties
   spring.datasource.url=jdbc:oracle:thin:@fn4.oracle.virtual.uniandes.edu.co:1521/PROD
   spring.datasource.username=ISIS2304E01202510
   spring.datasource.password=eNEwaHwswCxT
