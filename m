Return-Path: <cygwin-patches-return-3507-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5944 invoked by alias); 5 Feb 2003 17:22:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5934 invoked from network); 5 Feb 2003 17:22:12 -0000
Message-Id: <3.0.5.32.20030205122144.007edd30@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 17:22:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec odds and ends (cygcheck augmentation?)
In-Reply-To: <20030205164834.GE15400@redhat.com>
References: <3.0.5.32.20030205114159.00800620@mail.attbi.com>
 <3.0.5.32.20030205114159.00800620@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00156.txt.bz2

At 11:48 AM 2/5/2003 -0500, Christopher Faylor wrote:
>Pierre or Corinna,
>Have either of you considered adding code to cygcheck to check for more
>common ntsec "problems"?  At the very least, something along the lines
>of "your username isn't in /etc/passwd" seems like it would be
>worthwhile.

Chris,

I have though about that and actually have such a program. However it's
a Cygwin program. The idea being that it should reproduce *exactly* the
starting sequence of Cygwin, which has varied over the years. Keeping
cygcheck up to date might be a pain

In the patch I have just sent, the group name is set to "run mkpasswd"
if the username is not in passwd, and it is "run mkgroup" if the user name
is present but not his group.
So that should be clearly visible in "id", and visible but truncated in
"ls -l".
  
I have also changed the default uid and gid to 400/401 when the names are
missing, to make detection easy. It can then easily be done e.g. in 
/etc/profile or in sshd-user-config.

The question of "Why is my HOME C:\ " could also be handled in /etc/profile.
I was thinking of putting something like this in it:
echo "Hello this is /etc/profile"
echo "You are a new user and I will verify your configuration".
echo "Delete these lines once everything is well".
if [ $uid -eq 400 ]; then etc...
echo "Your HOME is set to $HOME, the rules are 1).. 2).. 3).. 4).. "

What do you think?

Pierre
  

