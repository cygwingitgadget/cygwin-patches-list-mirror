Return-Path: <cygwin-patches-return-4750-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26804 invoked by alias); 13 May 2004 21:21:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26790 invoked from network); 13 May 2004 21:21:56 -0000
Date: Thu, 13 May 2004 21:21:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
In-Reply-To: <20040513210306.GD11731@coe.bosbc.com>
Message-ID: <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com>
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
 <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com>
 <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com>
 <20040513210306.GD11731@coe.bosbc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q2/txt/msg00102.txt.bz2

On Thu, 13 May 2004, Christopher Faylor wrote:

> Either the hwnd exists or it doesn't.

Ok.

> If it does exist, just return it.  No locking required.

Ok, add:

if (ourhwnd)
  return ourhwnd;

to the beginning of my patch if your worried about the interlocked
overhead and don't mind a double test.

> If it doesn't exist, acquire the muto.

Ok, but now you have a new persistent object including an event.

> Does the hwnd exist now?  If so, release the muto and return the hwnd.

My patch does that without the muto.

> Otherwise, set up hwnd,

by waiting on the other thread with an event?  Since you already need that
event, why not use it instead of a muto?  You can clean up the event when
your done.  The muto stays around until the process exits.

> release the muto and return hwnd.

essentially exactly the same as my patch with one more uncleanable
object/handle.

Yes, I thought of that but it didn't seem as clean.  Once again, I don't
care, but I did have a good reason for choosing the method I presented.
(At least, IMHO it was a good reason).

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
