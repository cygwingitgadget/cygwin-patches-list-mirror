Return-Path: <cygwin-patches-return-2549-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30816 invoked by alias); 30 Jun 2002 17:13:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30801 invoked from network); 30 Jun 2002 17:13:13 -0000
Date: Sun, 30 Jun 2002 15:14:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fw: dup tty error.
Message-ID: <20020630171319.GC32201@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00c501c22036$2cfd0f20$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c501c22036$2cfd0f20$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00532.txt.bz2

On Sun, Jun 30, 2002 at 02:00:57PM +0100, Chris January wrote:
>2002-06-30  Christopher January <chris@atomice.net>
>
>	* tty.cc (tty_list::allocate_tty): retry FindWindow if it fails.

       __small_sprintf (buf, "cygwin.find.console.%d", myself->pid);
       SetConsoleTitle (buf);
-      Sleep (40);
-      console = FindWindow (NULL, buf);
+      for (int times = 0; times < 25 && console == NULL; times++)
+           {
+                 Sleep (40);
+          console = FindWindow (NULL, buf);
+           }
       SetConsoleTitle (oldtitle);
       Sleep (40);
       ReleaseMutex (title_mutex);

Is the SetConsoleTitle really succeeding when the window doesn't exist
yet?  That seems really broken to me but I guess that not too surprising.

I'm just wondering if we should be looping on the SetConsoleTitle rather
than the FindWindow.

cgf
