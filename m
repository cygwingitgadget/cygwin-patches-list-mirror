Return-Path: <cygwin-patches-return-3527-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5552 invoked by alias); 6 Feb 2003 17:47:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5542 invoked from network); 6 Feb 2003 17:47:53 -0000
Date: Thu, 06 Feb 2003 17:47:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec odds and ends
Message-ID: <20030206174750.GK5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030206145328.GH5822@cygbert.vinschen.de> <Pine.GSO.4.44.0302061135020.16397-200000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0302061135020.16397-200000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00176.txt.bz2

On Thu, Feb 06, 2003 at 11:37:16AM -0500, Igor Pechtchanski wrote:
> +<para>
> +If a user or group is not present in <filename>/etc/passwd</filename> (or
> +if a group is not present in <filename>/etc/group</filename>), it will have
> +a special user/group id of -1 (which would be shown by <command>ls</command>
> +as 65535).  In releases of Cygwin before 1.3.20, the user/group name shown
> +was '????????'.  Since Cygwin release 1.3.20, the name of a user with no
> +entry in <filename>/etc/passwd</filename> will be shown as `mkpasswd', and
> +the name of a group not in <filename>/etc/group</filename> will be shown as
> +`mkgroup', indicating the commands that should be run to alleviate the
> +situation.

Weeell... that's not quite correct, unfortunately.

- If the current user doesn't show up in /etc/passwd, it's *group* will
  be named "mkpasswd".

- Otherwise, if the login group of the current user isn't in /etc/group,
  it will be named "mkgroup".

- otherwise a group not in /etc/group will be shown as "????????"
  and a user not in /etc/passwd will be shown as "????????".

Nevertheless, thanks for the effort :-)
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
