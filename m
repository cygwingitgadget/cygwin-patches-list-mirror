Return-Path: <cygwin-patches-return-3196-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5282 invoked by alias); 15 Nov 2002 20:34:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5272 invoked from network); 15 Nov 2002 20:34:20 -0000
Message-ID: <3DD559FE.7010700@ece.gatech.edu>
Date: Fri, 15 Nov 2002 12:34:00 -0000
From: Charles Wilson <cwilson@ece.gatech.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: select on serial fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00147.txt.bz2

Nicholas Wourms wrote:

 > If you're feeling motivated, mkfifo() still needs implimenting ;-).

IIRC, fifo operation needs the cygwin daemon.  No sense in implementing 
mkfifo() if the fifo itself doesn't work.  Whatever happened to the 
daemon work?  conrad, oh con-rad...

As cgf asked on 11/4: "Status of cygserver?"
http://cygwin.com/ml/cygwin-developers/2002-11/msg00012.html
and on 11/5: "Anyone interested in checking out dgram socket problem 
(Conrad you still here?)"
http://cygwin.com/ml/cygwin-developers/2002-11/msg00018.html

Sadly, the first message elicited no replies; Thomas Pfaff picked up the 
second one -- but his solution didn't involve the cygserver code.

It seems that Conrad's last messages on any cygwin list were these:

"Re: cygwin_daemon merge"
http://cygwin.com/ml/cygwin-patches/2002-q3/msg00474.html

"cygserver usage questions"
http://cygwin.com/ml/cygwin-developers/2002-09/msg00196.html

and the astoundingly beautiful
"Re: So now you're a BigShot now? (clarification re. "MinGW Glib")
http://cygwin.com/ml/cygwin/2002-09/msg01445.html

Looks like Conrad disappeared circa 9/30/02.  Nobody told me to expect 
company on my vacation; I haven't seem him around these parts...

--Chuck
