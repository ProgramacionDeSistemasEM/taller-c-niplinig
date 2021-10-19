
ELEMENTS = 100000
imc: main.c clean	
	gcc -Wall -g main.c -o imc

test_promedio:
	@python3 ./datagen.pyc $(ELEMENTS)
	@./imc -p $(ELEMENTS) < test_data | tail -n 2 | grep -e Promedio -e promedio | awk '{print $$3}' | awk '{split($$0,a,"."); print a[1]}'
	@rm -f test_data
test_max: 
	@python3 ./datagen.pyc $(ELEMENTS)
	@./imc -p $(ELEMENTS) < test_data | tail -n 2 | grep -e Maximo -e maximo | awk '{print $$3}' | awk '{split($$0,a,"."); print a[1]}'
	@rm -f test_data
test_num_personas:
	@./imc -p 0 | grep "Numero de personas invalido" || true

test_numero_invalido: 
	@echo -e "a\n85\n1.9\n-65\n1.7" | tail -n 4 > test_data
	@./imc -p 2 | grep 'Numero invalido' || true
	@rm -f test_data

checksum_makefile:
	@sha256sum Makefile | awk '{print $$1}'

checksum_datagen:
	@sha256sum datagen.pyc | awk '{print $$1}'

.PHONY: clean
clean:
	rm -f imc test_data
