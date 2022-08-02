|%
:: Defines the types of each part of an item to match rss 2.0 item spec plus items for cue use.
::
+$  id  @                  :: cue id
+$  title  @t
::+$  thumbnail  @t        :: url for thumbnail or embed
+$  tags  @ta              :: cue tags for sorting
+$  link  @ta              :: url of the item
::+$  description  @t      :: synopsis preview or poster commentary
::+$  author  @t           :: email address of the author
::+$  patp  @p             :: @p of the author
::+$  category  @t         :: imported RSS items will keep their category
::+$  comments  @t         :: URL of a page for comments which can be urbit link
::+$  enclosure  @t        :: Describes a media object that is attached to the item
::+$  guid  @t             :: global ID from RSS item, often same as link
::+$  pubdate  @t
::+$  source  @t           :: RSS channel source URL
+$  item  [=title =tags =link done=? share=?]     :: item is the content of each entry without the id; done is bool for read/unread. re-add other parts after testing
+$  citem  [=id =item]              :: citem is item + ID for agent purposes. In 6mos I will think this is really dumb I'm sure
::
:: Poke actions
+$  action
  $%  [%add =id =item]     :: add new item
      [%edit =id =item]    :: overwrite item
      [%del =id]           :: delete item
      [%read =id]          :: toggle read/unread marker
      [%publish =id]       :: toggle public/private marker
  ==
:: Types for updates to subscribers or returned via scries
::
+$  logged  (pair @ action)
+$  update
  %+  pair  @
  $%  action
      [%cue list=(list citem)]
      [%logs list=(list logged)]    :: is these even necessary for p2p sharing? Yes except for read?
  ==
::
:: Types for our agent's state
+$  items  ((mop id item) gth)
+$  log  ((mop @ action) lth)       :: changelog that will allegedly be useful later
++  i-orm  ((on id item) gth)       :: streamlines mop functions
++  log-orm  ((on @ action) lth)    :: streamlines mop functions
--