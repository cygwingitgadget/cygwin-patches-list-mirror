From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
Date: Mon, 03 Dec 2001 20:22:00 -0000
Message-ID: <20011204042254.GB9987@redhat.com>
References: <911C684A29ACD311921800508B7293BA037D2827@cnmail>
X-SW-Source: 2001-q4/msg00285.html
Message-ID: <20011203202200.gH_14HVtzuK10MgMnCYE9J6RFCd5jMD_f1T-tH6hJgk@z>

On Mon, Dec 03, 2001 at 09:24:47PM -0500, Mark Bradshaw wrote:
>It just occurred to me that the patch I submitted for mkpasswd.c causes one
>of its error messages to be a bit misleading.  If you ask mkpasswd for a
>user that doesn't exist it will say:
>"NetUserEnum() failed with error 2221.
>That user doesn't exist."
>
>While the error number is correct, and the explanation on the second line is
>right, it's not actually NetUserEnum that's been called to determine that.
>I don't know if you care about this, but maybe the following patch could be
>thrown in to make that error a bit more generic (and correct).

I agree that the user doesn't have to know about NetUserEnum but the
error message should be something like "mkpasswd: user doesn't exist".

Some of the messages are like this already.  Are you interested in
genercizing the rest of the mkpasswd warnings?

cgf

>===============================
>
>2001-12-03  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
>
>	* mkpasswd.c: (enum_users): Fix an error message.
>
>===============================
