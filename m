Return-Path: <cygwin-patches-return-3243-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25018 invoked by alias); 29 Nov 2002 17:45:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25006 invoked from network); 29 Nov 2002 17:45:04 -0000
Date: Fri, 29 Nov 2002 09:45:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Internal get{pw,gr}XX calls
Message-ID: <20021129184501.E1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021126000911.00833190@mail.attbi.com> <3.0.5.32.20021126000911.00833190@mail.attbi.com> <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021129005937.00835100@h00207811519c.ne.client2.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00194.txt.bz2

Hi Pierre,

On Fri, Nov 29, 2002 at 12:59:37AM -0500, Pierre A. Humblet wrote:
> would run the code of "operator pwdgrp_state ()". It calls 
> etc_changed () and WaitForSingleObject (), which is completely useless
> in the context of internal calls that don't reread the files.

Ah, ok.

> I understand your idea, but not the details. See comments in the code above.

I'm sorry, I just typed the first idea and didn't check my thoughts
for correctness.  The correct implementation would be:

  static int
  grab_int (char **p)
  {
    char *src = *p, *stp;
    int val = strtol (src, &stp, 10);
    if (stp == src || *stp != ':')
      return -1;
    *p = stp + 1;
    return val;
  }

static int
parse_pwd (struct passwd &res, char *buf)
{
  [...]
  if ((res.pw_uid = grab_int (&buf)) < 0)
    return 0;
  if ((res.pw_gid = grab_int (&buf)) < 0)
    return 0;
  [...]

That means:  If the id string is invalid or empty (stp == src) or the
character after the number is not a colon (*stp != ':'), set src to the end of
the string (*src == '\0'), else set src to the next character after

> I was afraid that badly formed passwd entries (e.g. comments) in the file 
> could lead to internal pw_passwd fields being empty, and thus to 
> security holes. The fields following the gid are less important.

Yeah, I understood this.  I second that idea and therefore I suggested
to add the above lines.  There's no need to check fields after pw_gid
but it makes sense to check for the field up to gid at least for
security reasons.

> Besides that I am not sure if there is much value in being strict. Also
> is there a standard? For example can there be blank spaces between 
> the uid digits and the delimiting ":"?  

There's no standard and that makes sense.  The API is defined but why
does a system have to keep it in a passwd file?  Other methods are
not excluded.

Ok, I still have to look into your new patch...

Corinna
