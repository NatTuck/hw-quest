
import pyglet
import random
import math

def distance(aa, bb):
    dx = aa.x - bb.x
    dy = aa.y - bb.y
    return math.sqrt(pow(dx, 2) + pow(dy, 2))


class Bat:
    def __init__(self):
        self.x = 200 
        self.y = 300
        self.v = 0

    def tick(self):
        self.v -= 0.5
        self.y += self.v

    def flap(self):
        self.v += 15


class Bug:
    def __init__(self):
        self.x = random.randint(700, 1200)
        self.y = random.randint(25, 575)

    def tick(self):
        self.x -= 5

    def is_dead(self, bat):
        pass
        


# The main function for our program.
# None -> None
def main():
    MOS_N = 5

    # App state
    bat = Bat()
    bugs = [Bug() for _ii in range(MOS_N)]

    # App logic
    random.seed()

    window = pyglet.window.Window(width=800, height=600, resizable=False,
                                  caption="Bat Defender 3: Flappy Bat")

    # Thanks, Pyglet Sprite example.
    pyglet.resource.path = ['./images']
    pyglet.resource.reindex()

    background = pyglet.shapes.Rectangle(x = 0, y = 0,
                                         width=window.width,
                                         height=window.height,
                                         color=(255, 255, 255))

    def load_image(file, flip=False):
        image = pyglet.resource.image(file, flip_x=flip)
        image.anchor_x = image.width // 2
        image.anchor_y = image.height // 2
        return image


    bat_sp = pyglet.sprite.Sprite(load_image("bat.png"), x=bat.x, y=bat.y)
    bat_sp.scale = 0.5

    mss = []
    for ii in range(MOS_N):
        mm = pyglet.sprite.Sprite(load_image("mosquito.png", True),
                                  x=10, y=10 + ii)
        mm.scale = 0.5
        mss.append(mm)

        
    @window.event
    def on_draw():
        window.clear()
        background.draw()
        bat_sp.draw()
        for mm in mss:
            mm.draw()


    @window.event
    def on_key_press(key, _mods):
        bat.flap()

            
    @window.event
    def on_key_release(key, _mods):
        pass

            
    def tick(dt):
        nonlocal bugs

        bat.tick()
        bat_sp.x = bat.x
        bat_sp.y = bat.y

        # Handle moving mosquitoes
        #bugs = bat_eat_any_nearby_bugs(bat_y, bugs)
        
        for ii in range(MOS_N):
            bugs[ii].tick()
            mss[ii].update(x=bugs[ii].x, y=bugs[ii].y)

        
    pyglet.clock.schedule_interval(tick, 1 / 30.0)
    pyglet.app.run()


if __name__ == '__main__':
    main()
