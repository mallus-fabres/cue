/-  *cue
|%
++  dejs-action                             :: incoming pokes
  =,  dejs:format
  |=  jon=json
  ^-  action
  %.  jon
  %-  of
  :~  [%add (ot ~[id+ni title+so tags+(se %ta) link+(se %ta) done+bo public+bo])]           :: going to handle optional items in frontend
      [%edit (ot ~[id+ni title+so tags+(se %ta) link+(se %ta) done+bo public+bo])]
      [%del (ot ~[id+ni])]
      [%read (ot ~[id+ni])]
      [%read (ot ~[id+ni])]
  ==
++  enjs-update                             :: outgoing facts and scries
  =,  enjs:format
  |=  upd=update
  ^-  json
  |^
  ?+    -.q.upd  (logged upd)
      %cue
    %-  pairs
    :~  ['time' (numb p.upd)]
        ['item' a+(turn list.q.upd citem)]
    ==
  ::
      %logs
    %-  pairs
    :~  ['time' (numb p.upd)]
        ['logs' a+(turn list.q.upd logged)]
    ==
  ==
  ++  item
    |=  it=^item
    ^-  json
    %-  pairs
    :~  ['id' (numb id.it)]
        ['title' s+title.it]
        ['tags' tags.it]
        ['link' link.it]
        ['done' done.it]
        ['share' public.it]
    ==
  ++  logged
    |=  lgd=^logged
    ^-  json
    ?-    -.q.lgd
        %add
      %-  pairs
      :~  ['time' (numb p.lgd)]
          :-  'add'
          %-  pairs
          :~  ['id' (numb id.q.lgd)]
              ['title' s+title.q.lgd]
      ==  ==
        %edit
      %-  pairs
      :~  ['time' (numb p.lgd)]
          :-  'edit'
          %-  pairs
          :~  ['id' (numb id.q.lgd)]
              ['title' s+title.q.lgd]
      ==  ==
        %del
      %-  pairs
      :~  ['time' (numb p.lgd)]
          :-  'del'
          (frond 'id' (numb id.q.lgd))
      ==
       %read
      %-  pairs
      :~  ['time' (numb p.lgd)]
          :-  'read'
          (frond 'id' (numb id.q.lgd))
      ==
       %publish
      %-  pairs
      :~  ['time' (numb p.lgd)]
          :-  'publish'
          (frond 'id' (numb id.q.lgd))
      ==
    ==
  --
--