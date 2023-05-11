#Napiš funkci replace_csv_separator, která vezme název vstupního csv
# s oddělovačem ';' a vytvoří z něj csv s oddělovačem ','. Výsledek vypíše do souboru
# s názvem v output_file.
import csv

def replace_csv_separator(input_file, output_file):
    with open(input_file, mode='r', newline='') as input_csv:
        with open(output_file, mode='w', encoding='utf-8', newline='') as output_csv:
            cteme = csv.reader(input_csv, delimiter=';')
            piseme = csv.writer(output_csv, delimiter=',', lineterminator="\n")
            for row in cteme:
                piseme.writerow(row)
                
#Napiš funkci my_sum, která se bude chovat stejně jako funkce sum,
# tj. sečte všechny prvky seznamu a vrátí výsledek. Nemůžeš použít funkci sum.

def my_sum(promena):
    vysledek = 0
    for prvek in promena:
        vysledek += prvek
    return vysledek

print(my_sum)

#Napiš funkci my_count, která se bude chovat stejně jako funkce len,
# tj. spočítá všechny prvky seznamu a vrátí výsledek. Nemůžeš použít funkci len.

def my_count(list):
    pocitam = 0
    for prvek in list:
        pocitam += 1
    return pocitam
    

#Napiš funkci my_min, která se bude chovat stejně jako funkce min,
# tj. najde nejmenší prvek seznamu a vrátí výsledek. Nemůžeš použít funkci min.

def my_min(mujseznam):
    nejmensi_hodnota = mujseznam[0]
    for item in mujseznam:
        if item < nejmensi_hodnota:
            nejmensi_hodnota = item
    return nejmensi_hodnota


#Napiš funkci my_max, která se bude chovat stejně jako funkce max,
# tj. najde nejmenší prvek seznamu a vrátí výsledek. Nemůžeš použít funkci max.

def my_max(dalsiseznam):
    nejvetsi_hodnota = dalsiseznam[0]  
    for item in dalsiseznam:
        if item > nejvetsi_hodnota:
            nejvetsi_hodnota = item
    return nejvetsi_hodnota

# Set Slovníky

# Napiš funkci dict_sum, která sečte všechny hodnoty ve slovníku
# a vrátí výsledek. Nemůžeš použít funkci sum.

def dict_sum(input_dict):
    total = 0
    for value in input_dict.values():
        total += value
    return total

#Napiš funkci dict_shortest_key, která najde nejkratší klíč ve slovníku
# (předpokládejme, že klíče jsou řetězce).
# Pokud existuje víc nejkratších klíčů, vrátí ten první.

def dict_shortest_key(input_dict):
    shortest_key = None
    for key in input_dict:
        if shortest_key is None or len(key) < len(shortest_key):
            shortest_key = key
    return shortest_key

#Napiš funkci dict_max_key, která najde největší hodnotu ve slovníku
# a vrátí její klíč.Pokud existuje víc největších hodnot, vrátí klíč té první.

def dict_max_key(input_dict):
    max_key = None
    for key in input_dict:
        if max_key is None or input_dict[key] > input_dict[max_key]:
            max_key = key
    return max_key

#Soubory

# Napiš funkci cat, která vezme název souboru a vypíše jej do konzole.
# Pokud nefunguje test, zkuste do printu přidat end=""

def cat(input_file):
    with open(input_file, mode='r', encoding= "utf-8") as f:
        print(f.read(), end="")
    return f

#Napiš funkci file_count_lines, která spočítá řádky v souboru a vrátí
# výsledek. V parametru input_file očekávej název souboru. Nemůžeš použít funkci len.

def file_count_lines(input_file):
    count = 0
    with open(input_file, mode='r', encoding= "utf-8") as file:
        for line in file:
            count += 1
    return count


#Autorkou zadání je Adéla Bierská - https://github.com/adbi13 
    

