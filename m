Return-Path: <cygwin-patches-return-4860-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9701 invoked by alias); 17 Jul 2004 23:43:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9692 invoked from network); 17 Jul 2004 23:43:13 -0000
From: "Robert McNulty Junior" <sherlock64@bellsouth.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: [RFC] Reference counting on Audio objects for /dev/dsp
Date: Sat, 17 Jul 2004 23:43:00 -0000
Message-ID: <000001c46c57$ca2d0880$6501a8c0@sherlock64>
In-Reply-To: <Pine.GSO.4.58.0407171853220.19508@slinky.cs.nyu.edu>
X-SW-Source: 2004-q3/txt/msg00012.txt.bz2


>Replying to myself - a sure sign of schitzophrenia... :-)

>I'm wrong.  Some settings *are* kept in the fhandler objects (audiobits_,
>audiofreq_, audiochannels_, and audioformat_).  So CGF is right -
>archetypes will probably be the right solution here...  However, we still
>need reference counting for the Audio objects, since even with archet.ypes
>they'll be shared (unless you completely rewrite the code).

Igor, the correct spelling is schizophrenia, and it does not involve talking
to oneself.
From what I learned, the two minds that the doctors are talking about are a
sick mind and a well mind. It is controlled with medication like Haldol or
Seraquel.
Others take a new medication called Geodon.
If you want to learn more about mental illness, and its effects on the
persons and families involved, look up the NAMI website.
I have.
I'm much better now.
Most schizophrenics go undiagnosed. There are 2 million or more in the US
alone. These "problems" in the Cygwin mailing lists are not caused by me. So
don't blame me or my illness. Most real schizos don't even have computers or
know anything about computer science. I've only seen one person so far that
meets schizophrenia. He was hostile towards Corrina. He was hostile towards
me when I was trying to tell him to quit.
About your idea, I need to look at the patch, Gerd.
It could work. I'm just following this thread and found a misconception
about mental illness. And if you want to see real MI at work, watch ER.
Abby's mom is bipolar and Abby's finally going to college to get a
counseling degree in Mental Health. MH is a big problem today. Many have
lost their jobs to mental illness. Read a book on MI or watch "A Beautiful
Mind" by Ron Howard. Genius can be considered insanity. One of the greatest
minds in the world had mental illness. Albert Einstein. Insanity? He could
find his house when coming back from working at the university. Abraham
Lincoln had depression. His was from birth on. More recent celebrities are
Carrie Fisher from Star Wars, Margot Kidder from Superman. There might even
be someone at your work who's gone insane, but no one ever noticed. Its not
the ones who seek help that cause problems with others.
Sure fire way to tell if you have MI is: Do you drink alchoholic beverages
or use illegal drugs like cocaine, crack, morphine? Morphine is used by
hospitals to control a person's pain level after surgery. Any surgery. On
the streets, its causes delusions. The person involved in the illegal use
will hear voices in their heads telling them to do harm towards others.
Illegal drugs have been around forever, Opium is illegal. It is made from
poppy seeds grown in Afghanistan. Don't tell me about mental illness and
call me crazy until you seek the information. My thoughts are clear.
I never had it in the first place. Seek the info on MI and learn before you
make false assumptions about others.
I've been online since 1996. I used to call local BBS's. I read the
information. I know what I have and what I don't.
Don't blame me for your problems, Defaria. Or windows XP or Microsoft.
Blame yourself into buying into the myth. Windows XP is for business and
home users. Linux is for servers. Windows XP Professional is widely used by
businesses. Sure, Linux sales have risen. Only because the Linux users
believe they have a better product. I'm not convinced. I tried linux. I
downloaded and burned several ISO's. Linux does not support my current
hardware "TV PVR, DVD R/W" so I won't install it. I'm running XP Pro because
I can't find my original setup disks that I ordered from HP. So, many
features of the rest of the computer are missing. My synthesizer, I had to
find the driver for it at drivers.com. The setup file for XP does not work.
That is why I use Timidity. Open Source. I just built it and installed it
with the GCC cvs. If Linux is free, how come Red Hat and Mandrake sell it?
Free software is a joke to me. The only freedom I see with it is the ability
for the users to make changes to it. Something Microsoft does not do.
Windows Services for Unix is a joke too. I can't compile any software with
it. GCC on SFU does not compile timidity, another open source project. GCC
on Cygwin can.



