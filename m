From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] mkpasswd.c - allows selection of specific user
Date: Mon, 03 Dec 2001 18:25:00 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2827@cnmail>
X-SW-Source: 2001-q4/msg00284.html
Content-type: multipart/mixed; boundary="----------=_1583532850-65438-121"
Message-ID: <20011203182500.PPZ7WzDdWhYZp-jPpaIB3GdKysrjPELB6-A8lsrtzMo@z>

This is a multi-part message in MIME format...

------------=_1583532850-65438-121
Content-length: 1124

It just occurred to me that the patch I submitted for mkpasswd.c causes one
of its error messages to be a bit misleading.  If you ask mkpasswd for a
user that doesn't exist it will say:
"NetUserEnum() failed with error 2221.
That user doesn't exist."

While the error number is correct, and the explanation on the second line is
right, it's not actually NetUserEnum that's been called to determine that.
I don't know if you care about this, but maybe the following patch could be
thrown in to make that error a bit more generic (and correct).

===============================

2001-12-03  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

	* mkpasswd.c: (enum_users): Fix an error message.

===============================

--- mkpasswd.c	Wed Nov 21 20:55:41 2001
+++ mkpasswd.c.new	Mon Dec  3 21:17:14 2001
@@ -147,7 +147,7 @@ enum_users (LPWSTR servername, int print
 	  break;
 
 	default:
-	  fprintf (stderr, "NetUserEnum() failed with error %ld.\n", rc);
+	  fprintf (stderr, "Mkpasswd failed with error %ld.\n", rc);
 	  if (rc == NERR_UserNotFound) 
 	    fprintf (stderr, "That user doesn't exist.\n");
 	  exit (1);


------------=_1583532850-65438-121
Content-Type: text/x-diff; charset=us-ascii; name="mkpasswd.c.diff"
Content-Disposition: inline; filename="mkpasswd.c.diff"
Content-Transfer-Encoding: base64
Content-Length: 545

LS0tIG1rcGFzc3dkLmMJV2VkIE5vdiAyMSAyMDo1NTo0MSAyMDAxCisrKyBt
a3Bhc3N3ZC5jLm5ldwlNb24gRGVjICAzIDIxOjE3OjE0IDIwMDEKQEAgLTE0
Nyw3ICsxNDcsNyBAQCBlbnVtX3VzZXJzIChMUFdTVFIgc2VydmVybmFtZSwg
aW50IHByaW50CiAJICBicmVhazsKIAogCWRlZmF1bHQ6Ci0JICBmcHJpbnRm
IChzdGRlcnIsICJOZXRVc2VyRW51bSgpIGZhaWxlZCB3aXRoIGVycm9yICVs
ZC5cbiIsIHJjKTsKKwkgIGZwcmludGYgKHN0ZGVyciwgIk1rcGFzc3dkIGZh
aWxlZCB3aXRoIGVycm9yICVsZC5cbiIsIHJjKTsKIAkgIGlmIChyYyA9PSBO
RVJSX1VzZXJOb3RGb3VuZCkgCiAJICAgIGZwcmludGYgKHN0ZGVyciwgIlRo
YXQgdXNlciBkb2Vzbid0IGV4aXN0LlxuIik7CiAJICBleGl0ICgxKTsK

------------=_1583532850-65438-121--
