# GOD
class Human(object):
    # 静态字段
    live = True

    def __init__(self,name):
        # 普通字段
        self.name = name
    
man = Human('Adam')
woman = Human('Eve')

# 有静态字段，live属性
print(Human.__dict__)
# 有普通字段，name属性
man.__dict__

man.name
man.live =True

man.__dict__


# 可以为类添加静态字段

Human.newattr = 1
dir(Human)
Human.__dict__

# 内置类型不能添加属性和方法
# setattr(list, 'newattr','value')
# TypeError


# 显示object类所有子类
print(().__class__.__bases__[0].__subclasses__())








