:: *** example poke: :cue &cue-action [%add 1 'test entry' ~.tagtest ~.link %.n %.n]
/-  *cue
/+  default-agent, dbug, agentio
|%
+$  versioned-state
    $%  state-0
    ==
+$  state-0  [%0 =items =log]
+$  card  card:agent:gall
++  unique-time
  |=  [=time =log]
  ^-  @
  =/  unix-ms=@
    (unm:chrono:userlib time)
  |-
  ?.  (has:log-orm log unix-ms)
    unix-ms
  $(time (add unix-ms 1))
--
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    io    ~(. agentio bowl)
++  on-init  on-init:def  :: M3 add check for pals u care error msg if no
++  on-save
  ^-  vase
  !>(state)
::
++  on-load  _`this :: to nuke old state if vase changes in dev IF PROD CHANGE TYPE VERSION PROPERLY
::  |=  old-vase=vase
::  ^-  (quip card _this)
::  `this(state !<(versioned-state old-vase))
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
::  ?>  (our.bowl src.bowl)                        :: local only
  ?.  ?=(%cue-action mark)  (on-poke:def mark vase)
  =/  now=@  (unique-time now.bowl log)
  =/  act  !<(action vase)
  =.  state  (poke-action act)
  :_  this(log (put:log-orm log now act))
  ~[(fact:io cue-update+!>(`update`[now act]) ~[/updates])]
  ::
  ++  poke-action
    |=  act=action
    ^-  _state
    ?-    -.act
        %add                                            :: add cue item
      ?<  (has:i-orm items id.act)                      :: check id doesn't exist already
      state(items (put:i-orm items id.act item.act))
    ::
        %edit                                           :: replace with edited item
      ?>  (has:i-orm items id.act)
      state(items (put:i-orm items id.act item.act))
    ::
        %del                                            :: delete item
      ?>  (has:i-orm items id.act)
      state(items +:(del:i-orm items id.act))
    ::
        %read                                            :: toggle read-unread
      ?>  (has:i-orm items id.act)
           ?~  item=(get:i-orm items id.act)
          state
       state(items (put:i-orm items id.act u.item(done !done.u.item)))
    ::
       %publish                                         :: toggle public/private
          ?~  item=(get:i-orm items id.act)
          state
        state(items (put:i-orm items id.act u.item(public !public.u.item)))
    ==
  --
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
::  ?>  (team:title our.bowl src.bowl)        :: local only
  ?+  path  (on-watch:def path)
    [%updates ~]  `this
  ==
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  :: ?>  (team:title our.bowl src.bowl)
  =/  now=@  (unm:chrono:userlib now.bowl)
  ?+    path  (on-peek:def path)
        [%x %all *]
    ?+    t.t.path  (on-peek:def path)
        [%all ~]                               :: all public items
      :^  ~  ~  %cue-update
      !>  ^-  update
      [now %cue (tap:i-orm items)]             :: this is producting a list
    ::
        [%before @ @ ~]                        :: n items before date
      =/  before=@  (rash i.t.t.t.path dem)
      =/  max=@  (rash i.t.t.t.t.path dem)
      :^  ~  ~  %cue-update
      !>  ^-  update
      [now %cue (tab:i-orm items `before max)]
    ::
        [%between @ @ ~]                        :: items between date and date
      =/  start=@
        =+  (rash i.t.t.t.path dem)
        ?:(=(0 -) - (sub - 1))
      =/  end=@  (add 1 (rash i.t.t.t.t.path dem))
      :^  ~  ~  %cue-update
      !>  ^-  update
      [now %cue (tap:i-orm (lot:i-orm items `end `start))]
    ::
        [%has @ta ~]                            :: has particular tag
      =/  searched=@ta  (rash i.t.t.t.path dem)
      :^  ~  ~  %cue-update
      !>  ^-  update
      [now %cue (murn (tap:i-orm items) |=([k=@ v=[title=@t tags=@ta link=@ta done=? public=?]] ?.(=(tags.v searched) ~ (some [k v]))))] :: make list of items that have tag
    ==
    ::
       [%x %updates *]
    ?+    t.t.path  (on-peek:def path)
        [%all ~]
      :^  ~  ~  %cue-update
      !>  ^-  update
      [now %logs (tap:log-orm log)]
    ::
        [%since @ ~]
      =/  since=@  (rash i.t.t.t.path dem)
      :^  ~  ~  %cue-update
      !>  ^-  update
      [now %logs (tap:log-orm (lot:log-orm log `since ~))]
    ==
  ==
::
++  on-leave  on-leave:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--