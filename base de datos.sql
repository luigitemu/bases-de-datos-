--creacion de triggers

CREATE OR REPLACE TRIGGER <NOMBRE_TRIGGER>
    BEFORE|AFTER INSERT + |UPDATE | DELETE ON <TABLA>
    FOR EACH ROW WHEN <CONDICION> -- ESTA CONDICION ES OPCIONAL
    DECLARE

    BEGIN
        <INSTRUCCIONES>
    END;

    --EL ROOLBACK SI TIENE EFECTO SOBRE EL TRIGGER

    /*
    OPERACIONES         VARIABLE:NEW        VARIABLE:OLD
    INSERT              YES                 NO
    UPDATE              YES                 YES 
    DELETE              NO                  YES
    */ 

    --ejemplo de trigger

        CREATE OR REPLACE TRIGGER INCREMENTO_TBLDEPARTAMENTOS
        BEFORE INSERT ON INCREMENTO_TBLDEPARTAMENTOS
        FOR EACH ROW
        DECLARE
        BEGIN
            :NEW.IDDEPARTAMENTO := SQ_DEPTOS.NEXTVAL;
        END;
    /*
    crear un trigger  que se ejecute despues de la insercion de un dato en la tabla tbldepartamentos
    y al mismo tiempo guarde un registro en la tabla logs con la informacion de la insercion 
    */

        CREATE OR REPLACE TRIGGER NUEVO_DEPTO
        AFTER INSERT ON INCREMENTO_TBLDEPARTAMENTOS
        FOR EACH ROW
        DECLARE
        ULTIMO_VALOR NUMBER;
        BEGIN
        SELECT COUNT(*) INTO ULTIMO_VALOR FROM LOGS;
        ULTIMO_VALOR:= ULTIMO_VALOR+1;

        INSERT INTO LOGS (ULTIMO_VALOR , USER , SYSDATE, 
                    'SE INSERTO UN REGISTRO '||:NEW.IDDEPARTAMENTO||
                    ' '|| :NEW.NOMBREDEPARTAMENTO ' '||:NEW.IDPAIS);
             

        END;





















