Return-Path: <cygwin-patches-return-4890-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4917 invoked by alias); 10 Aug 2004 14:43:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4907 invoked from network); 10 Aug 2004 14:43:35 -0000
Date: Tue, 10 Aug 2004 14:43:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: array size problem in select.cc
Message-ID: <20040810144350.GU31522@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <200408101037.i7AAbBXn013222@mx3.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101037.i7AAbBXn013222@mx3.redhat.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00042.txt.bz2

On Aug 10 11:36, Charles Reindorf wrote:
> Cygwin developers,
> 
> I was browsing in "winsup/cygwin/select.cc" from snapshot 20040808-1 and I
> think I see an array size problem there, resutling in possible core dumps when
> selecting about 63 file descriptors. I wonder if the following patch is
> applicable?
> 
> -- Charles Reindorf.
> 
> *** ../cygwin.bak/select.cc	Tue Aug 10 11:27:26 2004
> --- select.cc	Tue Aug 10 11:27:38 2004
> ***************
> *** 223,229 ****
>   		    DWORD ms)
>   {
>     int wait_ret;
> !   HANDLE w4[MAXIMUM_WAIT_OBJECTS];
>     select_record *s = &start;
>     int m = 0;
>     int res = 0;
> --- 223,229 ----
>   		    DWORD ms)
>   {
>     int wait_ret;
> !   HANDLE w4[MAXIMUM_WAIT_OBJECTS+1];
>     select_record *s = &start;
>     int m = 0;
>     int res = 0;
> 

Good catch, but changing the first conditional in the loop would be
more correct, wouldn't it?

Corinna

Index: select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.93
diff -u -p -r1.93 select.cc
--- select.cc   10 Apr 2004 13:45:10 -0000      1.93
+++ select.cc   10 Aug 2004 14:20:15 -0000
@@ -233,7 +233,7 @@ select_stuff::wait (fd_set *readfds, fd_
      counting the number of active fds. */
   while ((s = s->next))
     {
-      if (m > MAXIMUM_WAIT_OBJECTS)
+      if (m >= MAXIMUM_WAIT_OBJECTS)
	{
	  set_sig_errno (EINVAL);
	  return -1;
