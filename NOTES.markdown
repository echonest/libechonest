TODO:
    - Error handling...

how do we integrate with ENMFP for those users that have access?

biggie: HTTP POST w/Audio File in request body.
 * HTTP POST with json in the body (catalog create/modify)
 * Audio + Video download helpers?

APP: biggie - uploading audio file for analysis.

ANALYTICS: flurry, localistics, google analytics


April 1st : Library


Resolution order:
    - md5
    - metadata
    - upload track

Artist (17)
    audio
        - artist
        - url (audiofile)
        - length
        - link (linked from)
        - date
        - id
    biographies
        - url
        - text
        - site (name)
        - license
            - url
            - attribution
            - type
    blogs - get a list of blog articles related to an artist
        - name
        - url
        - date posted
        - date found
        - summary
        - id
    familiarity - numerical estimation of how familiar an artist currently is to the world
        - familiarity
        - id
        - name (artist)
    hotttnesss
        - hotttnesss (floating point)
        - name
        - id
    images
        - url (to image resource)
        - license
            - url
            - attribution
            - type
    news
        - name
        - url
        - date_posted
        - date_found
        - summary
        - id
    profile
        - id
        - name
        - foreign_ids [
            - catalog
            - id
        ]
    reviews
        - name
        - url
        - summary
        - date_reviewed
        - date_found
        - image_url
        - release
        - id
    search
        - name
        - id
        - foreign_ids
            - catalog
            - foreign_id
    songs
        - id
        - title
    similar
    terms
    top_hottt
    top_terms
    urls
    video
Song (3)
    search
    profile
    identify POST/GET
Track (3)
    analyze POST
    profile
    upload POST
Playlist (3)
    static
    dynamic
    session_info
Catalog (9)
    overview
    create POST
    update POST
    status
    profile
    read
    feed
    delete POST
    list

35 methods

