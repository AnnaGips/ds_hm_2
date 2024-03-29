from pymongo import MongoClient
from bson.objectid import ObjectId


client = MongoClient("mongodb://localhost:27017/")
db = client["cats_db"]
collection = db["cats_collection"]




def read_all_cats():
    cats = collection.find()
    for cat in cats:
        print(cat)

def find_cat_by_name(name):
    cat = collection.find_one({"name": name})
    if cat:
        print(cat)
    else:
        print("Кіт з ім'ям {} не знайдено".format(name))


def update_age_by_name(name, new_age):
    collection.update_one({"name": name}, {"$set": {"age": new_age}})
    print("Вік кота з ім'ям {} був оновлений до {}".format(name, new_age))

def add_feature_by_name(name, new_feature):
    collection.update_one({"name": name}, {"$push": {"features": new_feature}})
    print("До кота з ім'ям {} була додана нова характеристика: {}".format(name, new_feature))


def delete_cat_by_name(name):
    collection.delete_one({"name": name})
    print("Кіт з ім'ям {} був видалений з колекції".format(name))

def delete_all_cats():
    collection.delete_many({})
    print("Всі коти були видалені з колекції")


if __name__ == "__main__":
    
    print("Всі коти в колекції:")
    read_all_cats()

    
    cat_name = input("Введіть ім'я кота для пошуку: ")
    print("Інформація про кота з ім'ям {}: ".format(cat_name))
    find_cat_by_name(cat_name)

    
    cat_name = input("Введіть ім'я кота для оновлення віку: ")
    new_age = int(input("Введіть новий вік кота: "))
    update_age_by_name(cat_name, new_age)

    
    cat_name = input("Введіть ім'я кота для додавання характеристики: ")
    new_feature = input("Введіть нову характеристику: ")
    add_feature_by_name(cat_name, new_feature)

    
    cat_name = input("Введіть ім'я кота для видалення: ")
    delete_cat_by_name(cat_name)

    
    confirm = input("Ви впевнені, що хочете видалити всіх котів з колекції? (y/n): ")
    if confirm.lower() == "y":
        delete_all_cats()

    
    client.close()

