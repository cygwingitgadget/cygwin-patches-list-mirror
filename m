From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>, <cygwin-developers@cygwin.com>
Subject: Re: Default chooser view?
Date: Fri, 29 Jun 2001 20:44:00 -0000
Message-id: <042601c10117$44122540$806410ac@local>
References: <034701c10106$34f6b6e0$806410ac@local> <036501c10108$b55383c0$806410ac@local> <20010629221309.A11334@redhat.com> <038301c1010a$bab7e840$806410ac@local> <039201c1010b$856f0c80$806410ac@local> <20010629223227.C11334@redhat.com> <03cb01c1010e$6d809dc0$806410ac@local> <20010629231541.A12500@redhat.com> <20010629231957.A12552@redhat.com> <041201c10116$5ab675e0$806410ac@local> <20010629234056.A12695@redhat.com>
X-SW-Source: 2001-q2/msg00386.html

done
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>; <cygwin-developers@cygwin.com>
Sent: Saturday, June 30, 2001 1:40 PM
Subject: Re: Default chooser view?


> Please check this in.
>
> cgf
>
> On Sat, Jun 30, 2001 at 01:40:05PM +1000, Robert Collins wrote:
> >ChangeLog
> >Sat Jun 30 2001 13:39:00 Robert Collins rbtcollins@hotmail.com
> >
> >    * choose.cc (create_listview): Call set_view_mode with VIEW_CATEGORY.
> >    (do_choose): Log the first category name.
> >
> >Rob
> >----- Original Message -----
> >From: "Christopher Faylor" <cgf@redhat.com>
> >To: <cygwin-developers@cygwin.com>; <cygwin-patches@cygwin.com>
> >Sent: Saturday, June 30, 2001 1:19 PM
> >Subject: Default chooser view?
> >
> >
> >> Btw, Robert, I see that the default view is still Partial.
> >> Didn't you say that you changed it to Category?  Or did I
> >> screw something up?
>
