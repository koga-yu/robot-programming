(load "models/room73b2-scene.l")
(load "models/h7-robot.l")

(setq *room* (room73b2))
(setq *robot* (h7))

(objects (list *robot* *room*))

(defun look-robot ()
    (objects (list *robot* *room*))
    (send *irtviewer* :look-all
        (geo::make-bounding-box
            (flatten (send-all (send *robot* :bodies) :vertices))
        )
    )
)

(send *robot* :move-to (send *room* :spot "cook-spot") :world)
(send *robot* :locate #f(0 0 550))

(setq *kettle* (send *room* :object "room73b2-kettle"))

(send *robot* :larm :inverse-kinematics (car (send *kettle* :handle)) :link-list (send *robot* :link-list (send *robot* :larm :end-coords :parent)) :move-target (send *robot* :larm :end-coords) :rotation-axis :z :debug-view t)

(send *robot* :larm :end-coords :assoc *kettle*)
(send *robot* :larm :move-end-pos #f(-50 0 50) :world :debug-view t :look-at-target t)

(send *robot* :move-to (send *room* :spot "coe-spot") :world)
(send *robot* :locate #f(0 0 550))
(look-robot)

(send *robot* :larm :move-end-pos #f(0 0 -40) :world :debug-view t :look-at-target t)
(send *robot* :larm :end-coords :dissoc *kettle*)

(send *robot* :larm :move-end-pos #f(0 0 100) :world :debug-view t :look-at-target t)
