
import pyglet
from pyglet.shapes import Rectangle, Triangle
import math


batch = pyglet.graphics.Batch()

def tri(cx, cy, size, flip):
    s2 = size / 2.0

    print("tri", cx, cy, size, flip)
    
    color = (0,0,0)
    if flip:
        color = (255, 255, 255)
        
    if flip:
        return Triangle(cx, cy + s2, cx - s2, cy - s2,
                        cx + s2, cy - s2, color, batch=batch)
    else:
        return Triangle(cx, cy - s2, cx - s2, cy + s2,
                        cx + s2, cy + s2, color, batch=batch)


def generate(nn, xx, yy, size, flip):
    if nn == 0:
        return []
    else:
        print("gen", xx, yy, size, flip)
        t0 = tri(xx, yy, size, flip)
        t1 = tri(xx, yy + size/4, size/2, not flip)
        return [t0, t1] + (
            generate(nn - 1, xx - size/4, yy + size*3/8, size/4, not flip))
    


# The main function for our program.
# None -> None
def main():
    window = pyglet.window.Window(width=800, height=600, resizable=False,
                                  caption="Many Triangles")
    
    background = Rectangle(x = 0, y = 0,
                           width=window.width,
                           height=window.height,
                           color=(255, 255, 255))

    tris = generate(2, 400, 300, 550, False)
    

    @window.event
    def on_draw():
        window.clear()
        background.draw()
        batch.draw()

    @window.event
    def on_key_press(key, _mods):
        pass
            
    @window.event
    def on_key_release(key, _mods):
        pass
            
    def tick(dt):
        pass

        
    pyglet.clock.schedule_interval(tick, 1 / 30.0)
    pyglet.app.run()


if __name__ == '__main__':
    main()
