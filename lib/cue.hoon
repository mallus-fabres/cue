/-  *cue
|%  :: --
++  dejs-action                             :: incoming pokes
  =,  dejs:format
  |=  jon=json
  ^-  action
  %.  jon
  %-  of
  :~  [%add (ot ~[id+ni title+so tags+(se %ta) link+so done+bo share+bo])]           :: going to handle optional items in frontend
      [%edit (ot ~[id+ni title+so tags+(se %ta) link+so done+bo share+bo])]
      [%del (ot ~[id+ni])]
      [%read (ot ~[id+ni])]
      [%publish (ot ~[id+ni])]
  ==
-- :: if you have a doc that ends in a comment you need a trailing empty line
