Return-Path: <cygwin-patches-return-5307-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3331 invoked by alias); 15 Jan 2005 19:11:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3291 invoked from network); 15 Jan 2005 19:11:08 -0000
Received: from unknown (HELO main.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 15 Jan 2005 19:11:08 -0000
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CptKB-00023Q-00
	for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2005 20:11:03 +0100
Received: from 146-115-127-135.c3-0.smr-ubr2.sbo-smr.ma.cable.rcn.com ([146.115.127.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2005 20:11:03 +0100
Received: from dave by 146-115-127-135.c3-0.smr-ubr2.sbo-smr.ma.cable.rcn.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Sat, 15 Jan 2005 20:11:03 +0100
To: cygwin-patches@cygwin.com
From: David Abrahams <dave@boost-consulting.com>
Subject: bug in texi2dvi, and hack patch
Date: Sat, 15 Jan 2005 19:11:00 -0000
Message-ID: <csbo8i$hql$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 146-115-127-135.c3-0.smr-ubr2.sbo-smr.ma.cable.rcn.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Cc: cygwin@cygwin.com
X-SW-Source: 2005-q1/txt/msg00010.txt.bz2

The latest /bin/texi2dvi contains (at line 102):

  # Systems which define $COMSPEC or $ComSpec use semicolons to separate
  # directories in TEXINPUTS.
  if test -n "$COMSPEC$ComSpec"; then
    path_sep=";"
  else
    path_sep=":"
  fi

I think I know what this is *trying* to accomplish, but I think it's
misguided.  At least on my system, all the environment variables defined
for my NT shell also show up in Cygwin, appropriately translated to use
":" separators.  So the above messes everything up when findprog(),
shown below, tries to locate the "tex" program:

findprog () {
  foundprog=false
  for dir in `echo $PATH | tr "$path_sep" " "`; do
    if test -x "$dir/$1"; then  # does anyone still need test -f?
      foundprog=true
      break
    fi
  done
  $foundprog
}

Paths end up being broken at spaces.  I'm actually a little concerned
about the code above because it seems to me that even after we fix the
path_sep problem it will fail to work correctly with paths containing
spaces.  I'm certain it's not the right long-term fix, but the little
hack patch I needed to get going again was to change line 105 from:

    path_sep=";"

to

    path_sep=":"

-- 
Dave Abrahams
Boost Consulting
http://www.boost-consulting.com
