[
    {
        "name": "api",
        "image": "${app_image}",
        "essential": true,
        "memoryReservation": 256,
        "environment": [
            {"name": "DB_HOST", "value": "${db_host}"},
            {"name": "DB_NAME", "value": "${db_name}"},
            {"name": "DB_USER", "value": "${db_user}"},
            {"name": "DB_PASS", "value": "${db_pass}"},
            {"name": "ALLOWED_HOSTS", "value": "${allowed_hosts}"}
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}",
                "awslogs-stream-prefix": "api"
            }
        },
        "mountPoints": [
            {
                "readOnly": false,
                "containerPath": "/var/www/html",
                "sourceVolume": "static"
            }
        ]
    },
    {
        "name": "proxy",
        "image": "${proxy_image}",
        "essential": true,
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80
            }
        ],
        "memoryReservation": 256,
        "environment": [
            {"name": "APP_HOST", "value": "127.0.0.1"},
            {"name": "LISTEN_PORT", "value": "80"}
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}",
                "awslogs-stream-prefix": "proxy"
            }
        },
        "mountPoints": [
            {
                "readOnly": true,
                "containerPath": "/var/www/html",
                "sourceVolume": "static"
            }
        ]
    }
]
