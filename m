From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to mkpasswd.c - allows selection of specific user
Date: Fri, 09 Nov 2001 17:01:00 -0000
Message-id: <20011109200132.A13417@redhat.com>
References: <911C684A29ACD311921800508B7293BA010A8FEF@cnmail>
X-SW-Source: 2001-q4/msg00183.html

Looks nice.  Have you sent in your assignment?  I don't remember if
we've received one from you or not and the person who could check for
me won't be back in the office until Monday.

Also, I think you want to look into ChangeLog formatting a little.  The
text below is not right.  Compare it against the description in
http://cygwin.com/contrib.html and the existing formats in ChangeLog.

cgf

On Fri, Nov 09, 2001 at 06:55:22PM -0500, Mark Bradshaw wrote:
>This patch allows a person to specify that only information for a particular
>user should be returned by mkpasswd.  It doesn't affect way mkpasswd gets
>its information, but only restricts what is actually output.  
>
>I had it go ahead and stop requesting more users when it had a user
>specified AND got a match.  I guess it could be rewritten to only request
>info on a specific user.  I'm just not sure how.  Oh well.  
>
>This patch worked fine on my win2k machine.
>
>Mark
>
>=============================================
>Fri 9 Nov 2001 18:15:00  Mark Bradshaw <bradshaw@staff.crosswalk.com>
>
>        * mkpasswd.c : Add -u option to allow specifying only one user
>
>=============================================
