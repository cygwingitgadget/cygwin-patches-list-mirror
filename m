Return-Path: <cygwin-patches-return-3169-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25931 invoked by alias); 14 Nov 2002 03:58:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25922 invoked from network); 14 Nov 2002 03:58:54 -0000
Date: Wed, 13 Nov 2002 19:58:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Cc: cygwin-patches@cygwin.com
Subject: Re: ntsec patch 1: uid==gid, chmod, alloc_sd, is_grp_member
Message-ID: <20021114035913.GA7756@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>,
	cygwin-patches@cygwin.com
References: <3DD27B59.3FA8990@ieee.org> <3DD159F7.45001468@ieee.org> <20021113135916.Q10395@cygbert.vinschen.de> <3DD27B59.3FA8990@ieee.org> <3.0.5.32.20021113223509.0082c960@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021113223509.0082c960@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00120.txt.bz2

On Wed, Nov 13, 2002 at 10:35:09PM -0500, Pierre A. Humblet wrote:
>At 05:50 PM 11/13/2002 +0100, Corinna Vinschen wrote:
>>
>>The above ls -l example shows the result if we don't use is_grp_member().
>>We already had a lot of problems due to this some time ago.  I won't return
>>to the old state.  I, for one, would better like to improve is_grp_member().
>
>Hello Corinna,
>
>Sorry, didn't respond to that paragraph in my previous e-mail.
>I agree that is_grp_member () is useful and withdraw my suggestion to 
>eliminate it.

I have nothing useful to add here other than the fact that I am
really loving this dialog.  I like to see things being hashed
out like this.

Pierre, I really appreciate your delving into issues here.  And, of
course I appreciate all that Corinna has done with ntsec.  I am sure
that she regrets ever listening to me when I suggested that she do
something with Windows permissions years ago.  Not that I am trying
to insert any claim to helping with ntsec.  This is all a black box
to me.

Anyway, I think between the two of you, we'll eventually have things
working as well as humanly possible on Windows.  I'm happy to see
you working on these issues.

My 2c.
cgf
