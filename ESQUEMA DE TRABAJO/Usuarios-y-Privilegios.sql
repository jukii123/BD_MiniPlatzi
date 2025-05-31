-- Usuario administrador con todos los privilegios
CREATE USER 'admin_platzi'@'%' IDENTIFIED BY 'Admin123!';
GRANT ALL PRIVILEGES ON platzi_db.* TO 'admin_platzi'@'%';

-- Usuario profesor con privilegios limitados
CREATE USER 'profesor_platzi'@'%' IDENTIFIED BY 'Prof123!';
GRANT SELECT, INSERT, UPDATE ON platzi_db.Curso TO 'profesor_platzi'@'%';
GRANT SELECT, INSERT, UPDATE ON platzi_db.Leccion TO 'profesor_platzi'@'%';

-- Usuario estudiante con privilegios de lectura y escritura limitados
CREATE USER 'estudiante_platzi'@'%' IDENTIFIED BY 'Estu123!';
GRANT SELECT ON platzi_db.Curso TO 'estudiante_platzi'@'%';
GRANT SELECT, INSERT ON platzi_db.Comentario TO 'estudiante_platzi'@'%';
GRANT SELECT, INSERT, UPDATE ON platzi_db.Progreso TO 'estudiante_platzi'@'%';
