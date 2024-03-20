
import pyglet
import random
import math


class Animal:
    def __init__(self):
        self.x = 0
        self.y = 0

    def distanceTo(self, other):
        dx = self.x - other.x
        dy = self.y - other.y
        return math.sqrt(pow(dx, 2) + pow(dy, 2))

    
class Bat(Animal):
    def __init__(self):
        self.x = 200 
        self.y = 300
        self.v = 0

    def tick(self):
        self.v -= 0.5
        self.y += self.v

    def flap(self):
        self.v += 15

    def can_reach(self, bug):
        return self.distanceTo(bug) < 40

    
def tick_all_bugs(bugs, bat):
    ys = []
    
    for bug in bugs:
        bug.tick()

        if bat.can_reach(bug):
            ys.append(Bug())
        else:
            ys.append(bug)

    return ys


class Bug(Animal):
    def __init__(self):
        self.x = random.randint(700, 1200)
        self.y = random.randint(25, 575)

    def tick(self):
        self.x -= 5

    def is_dead(self, bat):
        pass
        

    def is_off_screen(self):
        return self.x < 0
    

class Wall:
    def __init__(self):
        self.x = 800
        self.gap_top = random.randint(400, 700)
        self.height = 300


    def tick(self):
        self.x -= 2
        
        if self.x < 0:
            self.x = 800
            self.gap_top = random.randint(400, 700)


    def touches(self, other):
        return (abs(self.x - other.x) < 20 and
                (other.y > self.gap_top or
                 other.y < (self.gap_top - self.height)))

    
# The main function for our program.
# None -> None
def main():
    MOS_N = 5

    # App state
    bat = None
    bugs = None
    wall = None

    def reset():
        nonlocal bat, wall, bugs
        bat = Bat()
        wall = Wall()
        bugs = [Bug() for _ii in range(MOS_N)]

    reset()

    # App logic
    random.seed()

    window = pyglet.window.Window(width=800, height=600, resizable=False,
                                  caption="Bat Defender 3: Flappy Bat")

    # Thanks, Pyglet Sprite example.
    pyglet.resource.path = ['./images']
    pyglet.resource.reindex()

    batch = pyglet.graphics.Batch()
    layer0 = pyglet.graphics.Group(order=0)
    layer1 = pyglet.graphics.Group(order=1)
    layer2 = pyglet.graphics.Group(order=2)

    background = pyglet.shapes.Rectangle(x = 0, y = 0,
                                         width=window.width,
                                         height=window.height,
                                         color=(255, 255, 255),
                                         batch=batch,
                                         group=layer0)

    wall_top = pyglet.shapes.Rectangle(x = 100, y = 0,
                                       width=40,
                                       height=100,
                                       color=(0, 0, 0),
                                       batch=batch, group=layer2)
    wall_bot = pyglet.shapes.Rectangle(x = 100, y = 500,
                                       width=40,
                                       height=100,
                                       color=(0, 0, 0),
                                       batch=batch, group=layer2)

    
    def load_image(file, flip=False):
        image = pyglet.resource.image(file, flip_x=flip)
        image.anchor_x = image.width // 2
        image.anchor_y = image.height // 2
        return image


    bat_sp = pyglet.sprite.Sprite(load_image("bat.png"), x=bat.x, y=bat.y,
                                  batch=batch, group=layer2)
    bat_sp.scale = 0.5

    mss = []
    for ii in range(MOS_N):
        mm = pyglet.sprite.Sprite(load_image("mosquito.png", True),
                                  x=10, y=10 + ii,
                                  batch=batch, group=layer1)
        mm.scale = 0.5
        mss.append(mm)

        
    @window.event
    def on_draw():
        window.clear()
        batch.draw()


    @window.event
    def on_key_press(key, _mods):
        bat.flap()

            
    @window.event
    def on_key_release(key, _mods):
        pass

            
    def tick(dt):
        nonlocal bat, bugs

        wall.tick()
        wall_top.x = wall.x
        wall_top.y = wall.gap_top
        wall_top.height = 600-wall.gap_top
        wall_bot.x = wall.x
        wall_bot.y = 0
        wall_bot.height = wall.gap_top - wall.height

        bat.tick()

        if wall.touches(bat):
            print(bat.__dict__)
            print(wall.__dict__)
            reset()

        bat_sp.x = bat.x
        bat_sp.y = bat.y
       
        bugs = tick_all_bugs(bugs, bat)

        for ii in range(0, len(bugs)):
            mss[ii].update(x=bugs[ii].x, y=bugs[ii].y)


        
    pyglet.clock.schedule_interval(tick, 1 / 30.0)
    pyglet.app.run()


if __name__ == '__main__':
    main()
